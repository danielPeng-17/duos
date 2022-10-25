import { throwError } from "rxjs";
import { User } from "src/models/user";
import { UserInformation } from "src/models/user_info";
import { Injectable } from '@nestjs/common';

@Injectable()
export class UserService
{
   /**
    * Creates a new user in the firebase database
    */
    constructor(){

    }

   public CreateNewUser(user: UserInformation) {
        if(!user.first_name || !user.last_name){
            throwError(() => new Error("First or last name is missing"));
        } else if(!user.email)
        {
            throwError(() => new Error("Email is missing"));
        }
   } 
}