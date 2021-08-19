import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const loadComments=
functions.https.onCall(async (request)=> {
  const listofComments:Array<any>=[];
  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection("Users/8nof3StstZPRV2Q8dJrC/comments").get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listofComments.push(doc.data());
        });
        return listofComments;
      }).catch((error)=>{
        console.log(error);
        return listofComments;
      });
  return lists;
});

export const addComment=
functions.https.onCall(async (request)=>{
  const comment=request["comment"];
  const status:boolean= await admin.firestore().
      collection("Users/8nof3StstZPRV2Q8dJrC/comments")
      .add(comment).then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

export const deleteComment=
functions.https.onCall(async (request)=>{
  const commentID=request["commentID"];
  const status:boolean= await admin.firestore().
      doc(`Users/8nof3StstZPRV2Q8dJrC/comments/${commentID}`)
      .delete().then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

