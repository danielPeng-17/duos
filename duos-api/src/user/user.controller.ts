import { Controller, Post, Req, Body} from '@nestjs/common';
import { ApiUser } from 'src/api_models/api_user';
import { User } from 'src/models/user';
import { UserService } from './user.service';

@Controller('user')
export class UserController {

    constructor(private userService: UserService){}
    @Post()
    createNewUser(@Body() newUser: ApiUser): ApiUser {
        let user = new User(newUser.info);
        this.userService.CreateNewUser(user);
        return newUser;
    }
}