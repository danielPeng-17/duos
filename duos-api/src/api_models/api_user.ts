import { UserInformation } from "../models/user_info";

/*
Fields here are not final and based on the initial diagram, change them as needed.
*/

export class User {
    info: UserInformation;
    matched: Array<number>;
    categories: Array<number>;
}