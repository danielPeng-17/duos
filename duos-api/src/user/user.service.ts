import { throwError } from "rxjs";
import { User } from "src/models/user";
import { ConsoleLogger, Injectable } from '@nestjs/common';
import { createNewUserAsync, getUserAsync } from "src/firebase/database_functions/database_functions";
import { UserDto } from "src/Dtos/userDto";

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
   public GetUser(id: string){
        if(!id) {
            throwError(() => new Error("Id is empty or null"));
        }
        return getUserAsync(id);
   }
}