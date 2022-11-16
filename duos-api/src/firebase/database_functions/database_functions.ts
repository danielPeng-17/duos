import database from "../config";
import { collection, addDoc, getDocs, doc, updateDoc, query, where } from "firebase/firestore"; 
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

export const getUserAsync = async (uid: string) => {
    const q = query(collection(database, "user_profiles"), where("uid", "==", uid));
    const dbSnapshot = await getDocs(q);
    if(dbSnapshot.size == 1){
        return dbSnapshot.docs.at(0).data();
    }
    else {
        throw new Error("No such documents");
    }
}

export const updateUserAsync = async(id:string, editedUser: User) => {
    const docRef = doc(collection(database, "user_profiles"), id);
    const updateDocument = JSON.stringify(editedUser);
    await updateDoc(docRef, JSON.parse(updateDocument));
}
