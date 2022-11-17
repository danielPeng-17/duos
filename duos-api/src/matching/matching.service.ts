import { User } from "src/models/user";
import { Injectable } from '@nestjs/common';
import { addALiked, addMatch, createNewUserAsync, getAllUsersInCategory, getUserAsync, removeALiked } from "src/firebase/database_functions/database_functions";
import { likePayload } from "./matching.controller";



@Injectable()
export class MatchingService {
    /**
     * Creates a new user in the firebase database
     */
    constructor() {

    }

    public async GetNewPotentialMatches(id: string): Promise<User[]> {
        //TODO 
        // -pair based on preference 
        const thisUser = await getUserAsync(id)
        console.log(thisUser as User)
        const allUsers = await getAllUsersInCategory(thisUser.categories)
        return allUsers.filter(user => {
            const preLiked = thisUser.likes ? thisUser.likes.find(ele => ele == user.uid) : false//falses incause likes value doesn't exist in user
            const preMatched = thisUser.matched ? thisUser.matched.find(ele => ele == user.uid) : false
            return user.uid != id && !preLiked && !preMatched
        })

    }

    public async LikePerson(likerId: string, likedId: string): Promise<likePayload> {
        const likedUser = await getUserAsync(likedId) as User

        //skip is already matches
        if (likedUser.matched) {
            const alreadyMatched = likedUser.matched.find(ele => ele == likerId)
            if (alreadyMatched) {
                return {
                    matched: false,
                    matchedId: null
                }
            }
        }

        if (likedUser.likes) {
            const likedBack = likedUser.likes.find(ele => ele == likerId)
            if (likedBack) {
                //remove like of other user
                await removeALiked(likedId, likerId)
                //create match
                await addMatch(likerId, likedId)
                return {
                    matched: true,
                    matchedId: likedUser
                }
            }
        }

        //add to liked
        await addALiked(likerId, likedId)
        return {
            matched: false,
            matchedId: null
        }

    }

}