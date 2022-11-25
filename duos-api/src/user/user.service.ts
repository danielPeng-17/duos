import { throwError } from "rxjs";
import { User } from "src/models/user";
import { Injectable } from '@nestjs/common';
import { createNewUserAsync, getUserAsync, updatePartialUserAsync, updateUserAsync } from "src/firebase/database_functions/database_functions";
import { UpdateUserDto } from "./Dtos/userDto";

@Injectable()
export class UserService
{
    constructor(){

    }
    /**
    * Creates a new user in the firebase database
    */
   public CreateNewUser(user: User) {
        if(!user.info.first_name || !user.info.last_name){
            throwError(() => new Error("First or last name is missing"));
        } else if(!user.info.email){
            throwError(() => new Error("Email is missing"));
        }
        createNewUserAsync(user);
   }

    /**
    * Retrieves the user from the firebase database
    */
   public GetUser(uid: string){
        if(!uid) {
            throwError(() => new Error("Id is empty or null"));
        }
        return getUserAsync(uid);
   }

   public EditUser(uid: string, editedUser: User){
        if(!uid) {
            throwError(() => new Error("Id is empty or null"));
        }
        else if(!editedUser.info.first_name || !editedUser.info.last_name){
            throwError(() => new Error("First or last name is missing"));
        } 
        else if(!editedUser.info.email){
            throwError(() => new Error("Email is missing"));
        }
        return updateUserAsync(uid, editedUser);
   }

   public EditPartialUser(uid: string, userInfo: UpdateUserDto){
        if(!uid) {
            throwError(() => new Error("Id is empty or null"));
        }
        return updatePartialUserAsync(uid, userInfo);
   }

}