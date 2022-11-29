import { Controller, Get, Req } from '@nestjs/common';

@Controller()
export class AppController {
  constructor() {}

  @Get('/hello')
  getHello(@Req() req): string {
    return 'Hello world!    Email: ' + req['user']?.email + '    sub: ' + req['user']?.sub;
  }
}
``