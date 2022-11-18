import { UserInformation } from "./user_info";
//import { IsString} from "class-validator";


/*
Fields here are not final and based on the initial diagram, change them as needed.
*/

export class User {
    id: number;
    info: UserInformation;
    matched: Array<string>;
    likes: Array<string>;
    categories: Array<string>;
    uid: string;

    constructor(uid, info, categories) {
        this.info = info,
        this.matched = [],
        this.categories = categories,
        this.likes = [],
        this.uid = uid
    }
}