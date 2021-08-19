// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html';

import 'package:booksports/controllers.dart/logincontroller.dart';
import 'package:booksports/models/sportsEvent.dart';
import 'package:booksports/models/venueModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';

import '../models/userprofile.dart';

class APIStuffs {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  UserModel? user;
  User? firebaseUser;

  APIStuffs() {
    functions.useFunctionsEmulator('localhost', 5001);
  }

  Future<UserModel> loadProfile() async {
    // print(firebaseUser!.uid);
    LoginController _contr = Get.find();
    HttpsCallable caller = functions.httpsCallable("loadProfile");

    var response = await caller.call({
      'userID': _contr.user == null
          ? "5sQDOu92JTYfMYasTG4KAG4G6Rh1"
          : _contr.user!.uid
    });
    UserModel usermoel = UserModel.fromMap(response.data);
    this.user = usermoel;
    print(user!.toMap());
    return usermoel;
  }

  loadlikes() async {
    HttpsCallable caller = functions.httpsCallable("loadlikes");
    var response = await caller.call();
    Likes userLikes = Likes.fromMap(response.data);
  }

  loadVenueBookings() async {
    HttpsCallable caller = functions.httpsCallable("loadVenueBookings");
    var response = await caller.call();
    List venueBookings = response.data;
    List<VenueBookings> allvenueBookings = [];
    venueBookings.forEach((element) {
      allvenueBookings.add(VenueBookings.fromMap(element));
    });
    return allvenueBookings;
  }

  loadEventBookings() async {
    HttpsCallable caller = functions.httpsCallable("loadEventBookings");
    var response = await caller.call();
    List eventBookings = response.data;
    List<EventBookings> alleventBookings = [];
    eventBookings.forEach((element) {
      alleventBookings.add(EventBookings.fromMap(element));
    });
    return alleventBookings;
  }

//add it
  changeVenueBookingStatus(String bookingID) async {
    HttpsCallable caller = functions.httpsCallable("changeVenueBookingStatus");
    var response = await caller.call(
        {'userID': user!.userID, 'status': 'canceled', 'bookingID': bookingID});
    bool status = response.data;
    return status;
  }

  changeEventBookingStatus(String bookingID) async {
    HttpsCallable caller = functions.httpsCallable("changeEventBookingStatus");
    var response = await caller.call(
        {'userID': user!.userID, 'status': 'canceled', 'bookingID': bookingID});
    bool status = response.data;
    return status;
  }

  loadComments() async {
    HttpsCallable caller = functions.httpsCallable("loadComments");
    var response = await caller.call();
    UserComments userBookings = UserComments.fromMap(response.data);
  }

  addComment() async {
    HttpsCallable caller = functions.httpsCallable("addComment");
    var response = await caller.call();
    bool status = response.data;
  }

//add it
  deleteComment() async {
    HttpsCallable caller = functions.httpsCallable("deleteComment");
    var response = await caller.call();
    bool status = response.data;
  }

  createdEvents() async {
    HttpsCallable caller = functions.httpsCallable("createdEvents");
    var response = await caller.call();
    UserCreatedEvents userCreatedEvents =
        UserCreatedEvents.fromMap(response.data);
  }

//also add it
  unlike(Likes currentLike) {}

  Future<List<SportsEvent>> loadEvents() async {
    HttpsCallable caller = functions.httpsCallable("loadEvents");
    var response = await caller.call();
    List<SportsEvent> allEvents = [];
    List li = response.data;
    // print(li);
    li.forEach((element) {
      allEvents.add(SportsEvent.fromMap(element));
    });

    return allEvents;
  }

  searchForEvent(String value) async {
    HttpsCallable caller = functions.httpsCallable("searchforEvent");
    var response = await caller.call({'texttoSearch': value});
    List<SportsEvent> allEvents = [];
    List li = response.data;
    li.forEach((element) {
      allEvents.add(SportsEvent.fromMap(element));
    });
    return allEvents;
  }

  searchForVenue(String value) async {
    HttpsCallable caller = functions.httpsCallable("searchforVenue");
    var response = await caller.call({'texttoSearch': value});
    List<VenueModel> allVenues = [];
    List li = response.data;
    li.forEach((element) {
      allVenues.add(VenueModel.fromMap(element));
    });
    return allVenues;
  }

  saveNewUser(User user) async {
    HttpsCallable caller = functions.httpsCallable("saveUser");
    this.firebaseUser = user;
    print(firebaseUser!.uid);

    var response = await caller.call({
      "userData": {
        'name': (user.displayName != null) ? user.displayName : " ",
        'email': user.email,
        'userID': user.uid,
      }
    });
    bool status = response.data;
    return status;
  }

  bookVenue(VenueModel venue) async {
    HttpsCallable caller = functions.httpsCallable("addVenueBooking");

    var response = await caller.call({
      "booking": {
        'venueID': venue.venueID,
        'venueName': venue.name,
        'userID': user!.userID,
        'dateTime': DateTime.now().microsecondsSinceEpoch.toString(),
        'status': "confirmed"
      }
    });
    bool status = response.data;
    return status;
  }

  bookEvent(SportsEvent event) async {
    HttpsCallable caller = functions.httpsCallable("addEventBooking");

    var response = await caller.call({
      "dateTime": DateTime.now().microsecondsSinceEpoch.toString(),
      "status": 'confirmed',
      "eventName": event.name,
      'userID': user!.userID,
      'eventID': event.eventID
    });
    bool status = response.data;
    return status;
  }

  createEvent(SportsEvent newEvent) async {
    HttpsCallable caller = functions.httpsCallable("createEvent");
    print({"userID", this.user!.toMap()});
    var response = await caller.call({
      "eventInfo": newEvent.toMap(),
      "creatorName": this.user!.name,
      "creatorID": this.user!.userID
    });
    bool status = response.data;
    return status;
  }

  createVenue(VenueModel newVenue) async {
    HttpsCallable caller = functions.httpsCallable("addNewVenue");
    var response = await caller.call({
      "venue": newVenue.toMap(),
      "creatorName": this.user!.name,
      "creatorID": this.user!.userID
    });
    bool status = response.data;
    return status;
  }
}
