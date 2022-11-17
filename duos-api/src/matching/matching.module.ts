import { Module } from "@nestjs/common";
import { MatchingController } from "./matching.controller";
import { MatchingService } from "src/matching/matching.service";

@Module({
    controllers: [MatchingController],
    providers: [MatchingService]
})

export class MatchingModule {}