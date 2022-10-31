import { throwError } from "rxjs";
import { User } from "src/models/user";
import { ConsoleLogger, Injectable } from '@nestjs/common';
import { createNewUserAsync } from "src/firebase/database_functions/database_functions";

@Injectable()
export class UserService
{
   /**
    * Creates a new user in the firebase database
    */
    constructor(){

    }

   public CreateNewUser(user: User) {
        console.log(user);
        if(!user.info.first_name || !user.info.last_name){
            throwError(() => new Error("First or last name is missing"));
        } else if(!user.info.email){
            throwError(() => new Error("Email is missing"));
        }
        createNewUserAsync(user);
   } 
}