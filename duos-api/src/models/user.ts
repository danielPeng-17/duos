import { UserInformation } from "./user_info";
//import { IsString} from "class-validator";


/*
Fields here are not final and based on the initial diagram, change them as needed.
*/

export class User {
    id: number;
    info: UserInformation;
    matched: Array<number>;
    categories: Array<number>;
    
    constructor(info)
    {
        this.info = info,
        this.matched = [],
        this.categories = []
    }
}