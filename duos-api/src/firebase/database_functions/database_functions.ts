import database from "../config";
import { collection, addDoc, getDoc, doc, query, where, getDocs, DocumentReference, updateDoc, arrayRemove, arrayUnion } from "firebase/firestore";
import { User } from "src/models/user"
import { UpdateUserDto } from "../../user/Dtos/userDto";
import e from "express";

export function convertObjectToDotNotation(obj,jsonString={}, current='') {
    for(const key in obj) {
      let value = obj[key];
      let newKey = (current ? current + "." + key : key);  // joined key with dot
      if(value && typeof value === "object") {
        convertObjectToDotNotation(value, jsonString, newKey);  // it's a nested object, so do it again
      } else {
        jsonString[newKey] = value;  // it's not an object, so set the property
      }
    }
    return jsonString;
  }
  

export const getUserDocAsync = async (uid) => {
    const q = query(collection(database, "user_profiles"), where("uid", "==", uid));
    const documents = await getDocs(q);
    if (documents.size <= 0) throw new Error("No such user");
    return documents.docs[0];
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

export const getAllUsersInCategory = async (category_ids: DocumentReference[]): Promise<User[]> => {
    //note the in operator can only handle up to 10
    const q = query(collection(database, "user_profiles"), where("categories", 'array-contains-any', category_ids));
    const querySnapshot = await getDocs(q);
    let users: User[] = [];
    querySnapshot.forEach((doc) => {
        const user = doc.data() as User;
        users.push(user);
    })
    return users;
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

    const user1Data = {
        profile_picture_url: user1.get("info.profile_picture_url"),
        first_name: user1.get("info.first_name"),
        last_name: user1.get("info.last_name"),
        uid: firstUid
    }

    const user2Data = {
        profile_picture_url: user2.get("info.profile_picture_url"),
        first_name: user2.get("info.first_name"),
        last_name: user2.get("info.last_name"),
        uid: secondUid
    }

    await updateDoc(document, { matched: arrayUnion(user2Data) });
    await updateDoc(document2, { matched: arrayUnion(user1Data) });
}
export const updateUserAsync = async (uid: string, editedUser: User) => {
    const user = await getUserDocAsync(uid);
    const docRef = doc(collection(database, "user_profiles"), user.id);
    const updateDocument = JSON.stringify(editedUser);
    await updateDoc(docRef, JSON.parse(updateDocument));
}

export const updatePartialUserAsync = async (uid: string, editedPartialUser: UpdateUserDto) => {
    const user = await getUserDocAsync(uid);
    const docRef = doc(collection(database, "user_profiles"), user.id);
    if("categories" in editedPartialUser){
        const games = editedPartialUser['categories'];
        await updateDoc(docRef, {'categories': []});
        console.log(games);
        for(let i in games){
            const game = games[i];
            await updateDoc(docRef, {'categories': arrayUnion(game)});
        }
    }
    else{
        const updateDocument = JSON.stringify(convertObjectToDotNotation(editedPartialUser));
        await updateDoc(docRef, JSON.parse(updateDocument));
    }
}
