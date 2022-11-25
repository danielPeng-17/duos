import { IsArray, IsNotEmpty, IsOptional, IsString, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { UserInformation, UserInformationUpdateDto } from "src/models/user_info";
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


export class UpdateUserDto {
    @IsOptional()
    @ValidateNested({each: true})
    @Type(() => UserInformationUpdateDto)
    info: UserInformationUpdateDto;

    @IsOptional()
    @IsString()
    @IsNotEmpty()
    uid: string;

    @IsOptional()
    @IsArray()
    @IsNotEmpty()
    categories: string[];
}