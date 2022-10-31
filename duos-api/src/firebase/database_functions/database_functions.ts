import database from "../config";
import { collection, addDoc } from "firebase/firestore"; 
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
