import { IsArray, IsNotEmpty, IsString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { UserInformation } from "src/models/user_info";
/*
Fields here are not final and based on the initial diagram, change them as needed.
*/

export class UserDto {
    @ValidateNested({each: true})
    @Type(() => UserInformation)
    info: UserInformation;

    @IsString()
    @IsNotEmpty()
    uid: string;

    @IsArray()
    @IsNotEmpty()
    categories: string[];
}