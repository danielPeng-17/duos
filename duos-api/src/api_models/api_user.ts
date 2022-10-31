import { Injectable } from "@nestjs/common";
import { User } from "src/models/user";
import { UserInformation } from "../models/user_info";

/*
Fields here are not final and based on the initial diagram, change them as needed.
*/

export class ApiUser {
    info: UserInformation;

    toBaseModel(){
        return new User(this.info);
    }
}