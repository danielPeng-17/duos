import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response } from 'express';
import * as firebase from 'firebase-admin';
import { collection, query, where } from "firebase/firestore";
import database from '../firebase/config';
import { FirebaseService } from 'src/firebase/firebase.service';

@Injectable()
export class PreauthMiddleware implements NestMiddleware {

    private auth: firebase.auth.Auth;

    constructor(private firebaseService: FirebaseService) {
        this.auth = firebaseService.getAuth();
    }

    use(req: Request, res: Response, next: Function) {
        const token = req.headers.authorization;
        if (token != null && token != '') {
            this.auth.verifyIdToken(token.replace('Bearer ', ''))
                .then(async decodedToken => {
                    const user = {
                        userUID: decodedToken.userUID
                    }
                    const users = collection(database, "users");
                    const q = query(users, where("userUID", "==", user.userUID));
                    console.log('in here', q)
                    if (q) {
                        next();
                    }
                }).catch(error => {
                    console.error(error);
                    this.accessDenied(req.url, res);
                });
        } else {
            console.error("error: can not auth");
            this.accessDenied(req.url, res);
        }
    }

    private accessDenied(url: string, res: Response) {
        res.status(403).json({
            statusCode: 403,
            timestamp: new Date().toISOString(),
            path: url,
            message: 'Access Denied'
        });
    }
}