import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {v4 as uuid4} from "uuid";


export const addNewVenue=
functions.https.onCall(async (request)=> {
  const creatorName=request.creatorName;
  const creatorID=request.creatorID;
  const venue=request.venue;
  const venueID=uuid4();
  venue.venueID=venueID;

  const db=admin.firestore();
  const status:boolean= await db.collection("Venues").doc(venueID).set(venue)
      .then(async ()=>{
        return await admin.firestore().
            collection(`Venues/${venueID}/creator`)
            .add({"name": creatorName, "uuid": creatorID})
            .then(()=>{
              return true;
            }).catch(()=>{
              return false;
            });
      }).catch((error)=>{
        console.log(error);
        return false;
      });
  return status;
});

export const deleteVenue=
functions.https.onCall(async (request)=> {
  const venueID=request.venueID;
  const db=admin.firestore();
  const status:boolean= await db.doc(`Venues/${venueID}`).delete()
      .then(async ()=>{
        return true;
      }).catch((error)=>{
        console.log(error);
        return false;
      });
  return status;
});

export const updateVenueField=functions.https.onCall(async (request)=>{
  const venueID=request.venueID;
  const field=request.updateLocation;
  const value=request.updateValue;
  const updateType:string=request.updateType;

  if (updateType=="addition") {
    const status:boolean=await admin.firestore().doc(`Venues/${venueID}`)
        .update({[field]: admin.firestore.FieldValue.arrayUnion(value)}).
        then(()=>{
          return true;
        }).catch(()=>{
          return false;
        });
    return status;
  }

  if (updateType=="removal") {
    const status:boolean=await admin.firestore().doc(`Venues/${venueID}`)
        .update({[field]: admin.firestore.FieldValue.arrayRemove(value)}).
        then(()=>{
          return true;
        }).catch(()=>{
          return false;
        });
    return status;
  }
  return false;
});

export const updateText=functions.https.onCall(async (request)=>{
  const venueID=request.venueID;
  const field=request.updateLocation;
  const value=request.updateValue;
  const status:boolean=await admin.firestore().doc(`Venues/${venueID}`)
      .update({[field]: value}).
      then(()=>{
        return true;
      })
      .catch(()=>{
        return false;
      });
  return status;
});

export const addPicVideo=
functions.https.onCall(async (request)=>{
// const venueID=request.venueID;
// const Image
});

export const deletePicVideo=
functions.https.onCall(async (request)=>{
// const venueID=request.venueID;
// const Image
});

export const changePicVideo=
functions.https.onCall(async (request)=>{
// const venueID=request.venueID;
// const Image
});


/**
 * sample venue
 // eslint-disable-next-line max-len
// addNewVenue({"creatorName":"binHashim","creatorID":"sjkhdfklkj8m",
"venue" :{"desription": "long ass etext",
"facilities":["multipurpose","gym","football"],
"features":["children", "women-only"],
"location":"wuse, Abuja","name":"BigAss things","rating":-1}})
 */
