import { Module } from "@nestjs/common";
import { UserController } from "./user.controller";
import { UserService } from "src/user/user.service";

@Module({
    controllers: [UserController],
    providers: [UserService]
})

export class UserModule {}