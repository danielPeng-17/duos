import { User } from "src/models/user";
import { ConsoleLogger, Injectable } from '@nestjs/common';
import { createNewUserAsync } from "src/firebase/database_functions/database_functions";

@Injectable()
export class MatchingService {
    /**
     * Creates a new user in the firebase database
     */
    constructor() {

    }

    public GetNewPotentialMatches(toMatchWith: User): User[] {

        //need logic
        return [] as User[]
    }
}