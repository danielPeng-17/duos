import { IsNotEmpty, IsString, IsEmail, IsDateString, IsOptional, IsArray } from 'class-validator';

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
    @IsString()
    bio: string;

    @IsNotEmpty()
    @IsDateString()
    date_of_birth: Date;

    @IsNotEmpty()
    @IsString()
    hobbies: string;

    @IsNotEmpty()
    @IsString()
    languages: string;

    @IsNotEmpty()
    @IsString()
    location: string;

    @IsNotEmpty()
    @IsString()
    profile_picture_url: string;

    @IsNotEmpty()
    @IsString()
    dating_pref: string;

    igns: Array<string>;
}

export class UserInformationUpdateDto {
    @IsOptional()
    @IsNotEmpty()
    first_name: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    last_name: string;

    @IsOptional()
    @IsNotEmpty()
    @IsEmail()
    email: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    gender: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    bio: string;

    @IsOptional()
    @IsNotEmpty()
    @IsDateString()
    date_of_birth: Date;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    hobbies: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    languages: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    location: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    profile_picture_url: string;

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    dating_pref: string;

    @IsOptional()
    @IsArray()
    igns: Array<string>;
}
