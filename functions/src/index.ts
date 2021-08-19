import * as admin from "firebase-admin";
export * from "./likes/likes";
export * from "./comments/comments";
export * from "./profile/profile";
export * from "./bookings/bookings";
export * from "./events/events";
export * from "./venue/venue";
export * from "./search/search";
export * from "./search/searchbase";
admin.initializeApp();
/*
 {"creatorID":"reter","creatorName":"boys abre", "eventInfo":{"attendance": 4,
 "description":"we gon play ball",
 "link":"https://www.gmail.com",
 "location":"Wuse Park",
 "name":"GUYS BALL",
 "participant":"women_only",
 "commentCount":0,
 "likesCount":0,
 "dateTimeCreated":"1629317250",
 "creatorName":"e burst",
 "type":["football"]}}
*/


