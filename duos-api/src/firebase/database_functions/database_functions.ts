import database from "../config";
import { collection, addDoc, getDoc, doc, updateDoc } from "firebase/firestore"; 
import { User } from "src/models/user";

export const createNewUserAsync = async (user: User) => {
    try {
        const addUser = await addDoc(
            collection(database, "user_profiles"), 
            Object.assign({},user)
        );
    } catch(e)
    {
        console.log("Error encountered: ", e);
    }
}

export const getUserAsync = async (id: string) => {
    const document = doc(collection(database, "user_profiles"), id);
    const dbDoc = await getDoc(document);
    if(dbDoc.exists()){
        return dbDoc.data();
    }
    else {
        throw new Error("No such document");
    }
}

export const updateUserAsync = async(id:string, editedUser: User) => {
    const docRef = doc(collection(database, "user_profiles"), id);
    const updateDocument = JSON.stringify(editedUser);
    await updateDoc(docRef, JSON.parse(updateDocument));
}
