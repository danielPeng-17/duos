import { IsNotEmpty, IsString, IsEmail, IsDateString } from 'class-validator';

/*
Fields here are not final and based on the initial diagram, change them as needed.
*/

export class UserInformation {
    @IsNotEmpty()
    @IsString()
    first_name: string;

    @IsNotEmpty()
    @IsString()
    last_name: string;

    @IsNotEmpty()
    @IsEmail()
    email: string;

    @IsNotEmpty()
    @IsString()
    gender: string;

    @IsNotEmpty()
    @IsDateString()
    date_of_birth: Date;

    @IsNotEmpty()
    @IsString()
    dating_pref: string;

    igns: Array<string>;
}