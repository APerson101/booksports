import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const loadLikes=
functions.https.onCall(async (request)=> {
  const listoflikes:Array<any>=[];
  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection("Users/8nof3StstZPRV2Q8dJrC/likes").get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listoflikes.push(doc.data());
        });
        return listoflikes;
      }).catch((error)=>{
        console.log(error);
        return listoflikes;
      });
  return lists;
});

export const addLike=
functions.https.onCall(async (request)=>{
  const like=request["like"];
  const status:boolean= await admin.firestore().
      collection("Users/8nof3StstZPRV2Q8dJrC/likes")
      .add(like).then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

export const deleteLike=
functions.https.onCall(async (request)=>{
  const likeID=request["likeID"];
  const status:boolean= await admin.firestore().
      doc(`Users/8nof3StstZPRV2Q8dJrC/likes/${likeID}`)
      .delete().then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

