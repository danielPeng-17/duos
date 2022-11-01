import { initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';

// TODO: Replace the following with your app's Firebase project configuration
// See: https://firebase.google.com/docs/web/learn-more#config-object
const firebaseConfig = {
    apiKey: "AIzaSyBL7hnaTELYsdCfIceIbQrob06wobdOYYY",
    authDomain: "duos-fd03d.firebaseapp.com",
    projectId: "duos-fd03d",
    storageBucket: "duos-fd03d.appspot.com",
    messagingSenderId: "312799945662",
    appId: "1:312799945662:web:ca099b4d7ab924a2e2cfef",
    databaseURL: "https://duos-fd03d.northamerica-northeast1.firebaseio.com",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Realtime Database and get a reference to the service
const database = getFirestore(app);

export default database;
