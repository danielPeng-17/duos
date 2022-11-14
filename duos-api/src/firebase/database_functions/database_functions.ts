import database from "../config";
import { collection, addDoc, getDoc, doc, query, where, getDocs, DocumentReference, updateDoc, arrayRemove, arrayUnion } from "firebase/firestore";
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
        ids.push(doc.id)
    })
    return ids
}


export const removeALiked = async (personID: string, idToRemove: string) => {
    const document = doc(collection(database, "user_profiles"), personID);
    await updateDoc(document, { likes: arrayRemove(idToRemove) });
}

export const addALiked = async (personID: string, idToRemove: string) => {
    const document = doc(collection(database, "user_profiles"), personID);
    await updateDoc(document, { likes: arrayUnion(idToRemove) });
}

export const addMatch = async (firstID: string, secondID: string) => {
    const document = doc(collection(database, "user_profiles"), firstID);
    await updateDoc(document, { matches: arrayRemove(secondID) });
    const document2 = doc(collection(database, "user_profiles"), secondID);
    await updateDoc(document2, { matches: arrayRemove(firstID) });
}
export const updateUserAsync = async (id: string, editedUser: User) => {
    const docRef = doc(collection(database, "user_profiles"), id);
    const updateDocument = JSON.stringify(editedUser);
    await updateDoc(docRef, JSON.parse(updateDocument));
}
