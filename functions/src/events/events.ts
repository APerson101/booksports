import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {v4 as uuid4} from "uuid";


export const createEvent=
functions.https.onCall(async (request)=> {
  const event=request.eventInfo;
  const creatorName=request.creatorName;
  const creatorID=request.creatorID;
  const eventID=uuid4();
  event.eventID=eventID;
  const status: boolean = await admin.firestore().collection("Events")
      .doc(eventID).set(event)
      .then(async (snapshot)=>{
        const sta:boolean=
        await admin.firestore().collection(`Events/${eventID}/creator`).
            add({name: creatorName, uuid: creatorID}).then(()=>{
              return true;
            })
            .catch(()=>{
              return false;
            });
        return sta;
      }).catch((error)=>{
        console.log(error);
        return false;
      });
  return status;
});


export const loadEvents=
functions.https.onCall(async (request)=> {
  let listofEvents:Array<any>=[];
  const lists:Array<any>=[];
  listofEvents=await admin.firestore().collection("Events").get()
      .then(async (snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          lists.push(doc.data());
        });

        return lists;
      }).catch((error)=>{
        console.log(error);
        return [];
      });
  return listofEvents;
});

// deleting of subcollection

export const deleteEvent=
functions.https.onCall(async (request)=> {
  const eventID=request.eventID;
  const status:boolean= await admin.firestore().doc(`Events/${eventID}`)
      .delete()
      .then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error);
        return false;
      });
  return status;
});

export const modifyEventFields=
functions.https.onCall((request)=> {
  admin.firestore().doc("Users/8nof3StstZPRV2Q8dJrC").get()
      .then((snapshot)=>{
        console.log(snapshot.data());
      }).catch((error)=>{
        console.log(error);
      });
});

export const addEventPicVideo=
functions.https.onCall((request)=> {
  admin.firestore().doc("Users/8nof3StstZPRV2Q8dJrC").get()
      .then((snapshot)=>{
        console.log(snapshot.data());
      }).catch((error)=>{
        console.log(error);
      });
});

export const changeEventPicVideo=
functions.https.onCall((request)=> {
  admin.firestore().doc("Users/8nof3StstZPRV2Q8dJrC").get()
      .then((snapshot)=>{
        console.log(snapshot.data());
      }).catch((error)=>{
        console.log(error);
      });
});

export const deleteEventPicVideo=
functions.https.onCall((request)=> {
  admin.firestore().doc("Users/8nof3StstZPRV2Q8dJrC").get()
      .then((snapshot)=>{
        console.log(snapshot.data());
      }).catch((error)=>{
        console.log(error);
      });
});

