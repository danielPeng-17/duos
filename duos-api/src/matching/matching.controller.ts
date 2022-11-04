import { Controller, Get, Req, Param, Body, Request } from '@nestjs/common';
import { User } from 'src/models/user';
import { MatchingService } from './matching.service';

@Controller('matching')
export class MatchingController {

    constructor(private matchingService: MatchingService) { }
    // @Get()
    // getPotentialMatches(@Req() request: Request): Promise<string[]> {
    //     const thisUser = request['user']
    //     const matchingDeck = this.matchingService.GetNewPotentialMatches(thisUser);
    //     return matchingDeck;
    // }

    @Get(':id')
    testMatches(@Param('id') id: string): Promise<string[]> {
        const matchingDeck = this.matchingService.GetNewPotentialMatches(id);
        return matchingDeck;
    }
}