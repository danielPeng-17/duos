import { IsNotEmpty, IsString, IsEmail } from 'class-validator';

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

    @IsEmail()
    email: string;

    @IsNotEmpty()
    @IsString()
    gender: string;

    @IsNotEmpty()
    date_of_birth: Date;

    @IsNotEmpty()
    @IsString()
    dating_pref: string;

    igns: Array<string>;
}