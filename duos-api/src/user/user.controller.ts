import { Controller, Post, Body, Get, Param, Put} from '@nestjs/common';
import { UserDto } from 'src/user/Dtos/userDto';
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

    @Put(':id')
    editUser(@Param('id') id: string, @Body() editUser:UserDto): UserDto {
        let user = new User(editUser.info);
        this.userService.EditUser(id, user);
        return editUser;
    }
}