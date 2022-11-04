import database from "../config";
import { collection, addDoc, getDoc, doc, query, where, getDocs, DocumentReference } from "firebase/firestore";
import { User } from "src/models/user"

export const createNewUserAsync = async (user: User) => {
    try {
        const addUser = await addDoc(
            collection(database, "user_profiles"),
            Object.assign({}, user)
        );
    } catch (e) {
        console.log("Error encountered: ", e);
    }
}

export const getUserAsync = async (id: string) => {
    const document = doc(collection(database, "user_profiles"), id);
    const dbDoc = await getDoc(document);
    if (dbDoc.exists()) {
        console.log("got you")
        return dbDoc.data();
    }
    else {
        throw new Error("No such document");
    }
}

export const getAllUsersInCategory = async (category_ids: DocumentReference[]): Promise<string[]> => {
    //note the in operator can only handle up to 10
    const q = query(collection(database, "user_profiles"), where("categories", 'array-contains-any', category_ids));

    const querySnapshot = await getDocs(q);
    let ids: string[] = []
    querySnapshot.forEach((doc) => {
        console.log('cat', doc.id)
        ids.push(doc.id)
    })
    return ids
}