import { Controller, Get, Req, Param, Body, Request, Post } from '@nestjs/common';
import { User } from 'src/models/user';
import { MatchingService } from './matching.service';

export interface likePayload {
    matched: boolean,
    matchedId: null | string,
}

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
    testMatches(@Param('id') id: string): Promise<User[]> {
        const matchingDeck = this.matchingService.GetNewPotentialMatches(id);
        return matchingDeck;
    }



    @Post(':id/like/:other')
    likedProfile(@Param('id') id: string, @Param('other') likedId: string): Promise<likePayload> {
        //get userID
        const payload = this.matchingService.LikePerson(id, likedId)

        return payload
    }

    // @Get('test')
    // test(@Req() request: Request) {
    //     return ' Hello' + request['user']?.email + '!';
    // }
}