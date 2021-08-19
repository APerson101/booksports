import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const loadProfile=
functions.https.onCall(async (request)=> {
  const userID=request.userID;
  console.log(userID);
  const data=await admin.firestore().doc(`Users/${userID}`).get()
      .then((snapshot)=>{
        console.log(snapshot.data());
        return snapshot.data();
      }).catch((error)=>{
        console.log(error);
        return {};
      });
  return data;
});


export const loadlikes=
functions.https.onCall(async (request)=> {
  const listofLikes:Array<any>=[];
  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection("Users/8nof3StstZPRV2Q8dJrC/likes").get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listofLikes.push(doc.data());
        });
        return listofLikes;
      }).catch((error)=>{
        console.log(error);
        return listofLikes;
      });
  return lists;
});

export const loadBookings=
functions.https.onCall(async (request)=> {
  const listofBookings:Array<any>=[];
  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection("Users/8nof3StstZPRV2Q8dJrC/bookings").get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listofBookings.push(doc.data());
        });
        return listofBookings;
      }).catch((error)=>{
        console.log(error);
        return listofBookings;
      });
  return lists;
});

export const loadCreatedEvents=
functions.https.onCall(async (request)=> {
  const listofcreatedEvents:Array<any>=[];
  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection("Users/8nof3StstZPRV2Q8dJrC/createdEvents").get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listofcreatedEvents.push(doc.data());
        });
        return listofcreatedEvents;
      }).catch((error)=>{
        console.log(error);
        return listofcreatedEvents;
      });
  return lists;
});

export const saveUser=functions.https.onCall(async (request)=>{
  const userData=request.userData;
  const userID=userData.userID;
  const status:boolean=await admin.firestore().doc(`Users/${userID}`)
      .create(userData).then(()=>{
        return true;
      }).catch((error)=>{
        // console.log(error); maybe document already exists
        return true;
      });
  return status;
});


