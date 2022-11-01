import { Controller, Post, Body, Get, Param} from '@nestjs/common';
import { UserDto } from 'src/Dtos/userDto';
import { User } from 'src/models/user';
import { UserService } from './user.service';

@Controller('user')
export class UserController {

    constructor(private userService: UserService){}

    @Get(':id')
    getUser(@Param('id') id: string){
        return this.userService.GetUser(id);
    }

    @Post()
    createNewUser(@Body() newUser: UserDto): UserDto {
        let user = new User(newUser.info);
        this.userService.CreateNewUser(user);
        return newUser;
    }
}