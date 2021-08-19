import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {v4 as uuid4} from "uuid";


export const loadEventBookings=
functions.https.onCall(async (request)=> {
  const userID=request.userID;
  const listofbookings:Array<any>=[];
  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection(`Users/${userID}/eventBookings`).get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listofbookings.push(doc.data());
        });
        return listofbookings;
      }).catch((error)=>{
        console.log(error);
        return listofbookings;
      });
  return lists;
});
export const loadVenueBookings=
functions.https.onCall(async (request)=> {
  const listofbookings:Array<any>=[];
  const userID=request.userID;

  let lists:Array<any>=[];

  lists=await admin.firestore()
      .collection(`Users/${userID}/venueBookings`).get()
      .then((snapshot)=>{
        snapshot.docs.forEach((doc)=>{
          listofbookings.push(doc.data());
        });
        return listofbookings;
      }).catch((error)=>{
        console.log(error);
        return listofbookings;
      });
  return lists;
});

export const addVenueBooking=
functions.https.onCall(async (request)=>{
  const booking=request["booking"];
  const userID=booking.userID;
  const bookingID=uuid4();
  booking.bookingID=bookingID;
  const status:boolean= await admin.firestore().
      collection(`Users/${userID}/venueBookings`).doc(bookingID)
      .set(booking).then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

export const addEventBooking=
functions.https.onCall(async (request)=>{
  const booking=request["booking"];
  const userID=booking.userID;
  const bookingID=uuid4();
  booking.bookingID=bookingID;
  const status:boolean= await admin.firestore().
      collection(`Users/${userID}/eventBookings`).doc(bookingID)
      .set(booking).then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

export const changeEventBookingStatus=
functions.https.onCall(async (request)=>{
  const bookingID=request["bookingID"];
  const userID=request.userID;
  const newStatus=request["status"];
  const status:boolean= await admin.firestore().
      doc(`Users/${userID}/eventBookings/${bookingID}`)
      .update({"status": newStatus}).then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

export const changeVenueBookingStatus=
functions.https.onCall(async (request)=>{
  const bookingID=request["bookingID"];
  const userID=request.userID;
  const newStatus=request["status"];
  const status:boolean= await admin.firestore().
      doc(`Users/${userID}/venueBookings/${bookingID}`)
      .update({"status": newStatus}).then(()=>{
        return true;
      }).catch((error)=>{
        console.log(error); return false;
      });
  return status;
});

