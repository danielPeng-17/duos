import { User } from "src/models/user";
import { ConsoleLogger, Injectable } from '@nestjs/common';
import { createNewUserAsync, getAllUsersInCategory, getUserAsync } from "src/firebase/database_functions/database_functions";

@Injectable()
export class MatchingService {
    /**
     * Creates a new user in the firebase database
     */
    constructor() {

    }

    public async GetNewPotentialMatches(id: string): Promise<string[]> {
        //TODO 
        // -exclude already matched/swiped
        // -pair based on preference 
        const thisUser = await getUserAsync(id)
        const allUsers = await getAllUsersInCategory(thisUser.categories)
        return allUsers.filter(ele => ele != id)

    }

}