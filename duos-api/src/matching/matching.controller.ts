import { Controller, Get, Req, Body } from '@nestjs/common';
import { ApiUser } from 'src/api_models/api_user';
import { User } from 'src/models/user';
import { MatchingService } from './matching.service';

@Controller('matching')
export class MatchingController {

    constructor(private matchingService: MatchingService) { }
    @Get()
    getPotentialMatches(@Req() request: Request): User[] {
        const thisUser = request['user']
        const matchingDeck = this.matchingService.GetNewPotentialMatches(thisUser);
        return matchingDeck;
    }
}