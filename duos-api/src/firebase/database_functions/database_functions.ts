import database from "../config";
import { collection, addDoc, getDoc, doc, query, where, getDocs, DocumentReference, updateDoc, arrayRemove, arrayUnion } from "firebase/firestore";
import { User } from "src/models/user"

export const getUserDocAsync = async (uid) => {
    const q = query(collection(database, "user_profiles"), where("uid", "==", uid));
    const documents = await getDocs(q);
    if(documents.size <= 0) throw new Error("No such user");
    return documents.docs.at(0);
}

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

export const getUserAsync = async (uid: string) => {
    const user = await getUserDocAsync(uid);
    return user.data();
}

export const getAllUsersInCategory = async (category_ids: DocumentReference[]): Promise<string[]> => {
    //note the in operator can only handle up to 10
    const q = query(collection(database, "user_profiles"), where("categories", 'array-contains-any', category_ids));
    const querySnapshot = await getDocs(q);
    let ids: string[] = [];
    querySnapshot.forEach((doc) => {
        const user = doc.data() as User;
        ids.push(user.uid);
    })
    return ids;
}

export const removeALiked = async (uid: string, idToRemove: string) => {
    const user = await getUserDocAsync(uid);
    const docRef = doc(collection(database, "user_profiles"), user.id);
    await updateDoc(docRef, { likes: arrayRemove(idToRemove) });
}

export const addALiked = async (uid: string, idToAdd: string) => {
    const user = await getUserDocAsync(uid);
    const docRef = doc(collection(database, "user_profiles"), user.id);
    await updateDoc(docRef, { likes: arrayUnion(idToAdd) });
}

export const addMatch = async (firstUid: string, secondUid: string) => {
    const user1 = await getUserDocAsync(firstUid);
    const user2 = await getUserDocAsync(secondUid);

    const document = doc(collection(database, "user_profiles"), user1.id);
    const document2 = doc(collection(database, "user_profiles"), user2.id);

    await updateDoc(document, { matched: arrayUnion(secondUid) });
    await updateDoc(document2, { matched: arrayUnion(firstUid) });
}
export const updateUserAsync = async (uid: string, editedUser: User) => {
    const user = await getUserDocAsync(uid);
    const docRef = doc(collection(database, "user_profiles"), user.id);
    const updateDocument = JSON.stringify(editedUser);
    await updateDoc(docRef, JSON.parse(updateDocument));
}
