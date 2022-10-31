import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
//import { PreauthMiddleware } from './auth/preauth.middlewate';
import { PreauthMiddleware } from './auth/preauth.middlewate';
import { FirebaseService } from './firebase/firebase.service';

@Module({
  imports: [UserModule],
  controllers: [AppController],
  providers: [AppService, FirebaseService],
})
export class AppModule {
  // configure(consumer: MiddlewareConsumer) {
  //   consumer.apply(PreauthMiddleware).forRoutes({
  //     path: '*', method: RequestMethod.ALL
  //   });
  // }
}
