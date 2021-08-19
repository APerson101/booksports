import 'dart:convert';

class UserModel {
  String name;
  String gender;
  String email;
  String imageBucket;
  String userID;
  UserModel(
      {required this.name,
      required this.gender,
      required this.email,
      required this.imageBucket,
      this.userID = ""});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'imageBucket': imageBucket,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        gender: map['gender'],
        email: map['email'],
        imageBucket: map['imageBucket'],
        userID: map["userID"]);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

class UserCreatedEvents {
  String eventName;
  String eventID;
  UserCreatedEvents({
    required this.eventName,
    required this.eventID,
  });
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'eventID': eventID,
    };
  }

  factory UserCreatedEvents.fromMap(Map<String, dynamic> map) {
    return UserCreatedEvents(
      eventName: map['eventName'],
      eventID: map['eventID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCreatedEvents.fromJson(String source) =>
      UserCreatedEvents.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserCreatedEvents(eventName: $eventName, eventID: $eventID)';
}

class EventBookings {
  String dateTime;
  String status;
  String bookingType;
  String bookedID;
  EventBookings({
    required this.dateTime,
    required this.status,
    required this.bookingType,
    required this.bookedID,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'status': status,
      'bookingType': bookingType,
      'bookedID': bookedID,
    };
  }

  factory EventBookings.fromMap(Map<String, dynamic> map) {
    return EventBookings(
      dateTime: map['dateTime'],
      status: map['status'],
      bookingType: map['bookingType'],
      bookedID: map['bookedID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventBookings.fromJson(String source) =>
      EventBookings.fromMap(json.decode(source));
}

class VenueBookings {
  String venueID;
  String venueName;
  String userID;
  String dateTime;
  String status;
  String bookingID;
  VenueBookings({
    required this.venueID,
    required this.venueName,
    required this.userID,
    required this.dateTime,
    required this.status,
    required this.bookingID,
  });

  Map<String, dynamic> toMap() {
    return {
      'venueID': venueID,
      'venueName': venueName,
      'userID': userID,
      'dateTime': dateTime,
      'status': status,
      'bookingID': bookingID,
    };
  }

  factory VenueBookings.fromMap(Map<String, dynamic> map) {
    return VenueBookings(
      venueID: map['venueID'],
      venueName: map['venueName'],
      userID: map['userID'],
      dateTime: map['dateTime'],
      status: map['status'],
      bookingID: map['bookingID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VenueBookings.fromJson(String source) =>
      VenueBookings.fromMap(json.decode(source));
}

class UserComments {
  String commentType;
  String postID;
  String DateTime;
  String comment;
  String userName;
  UserComments(
      {required this.commentType,
      required this.postID,
      required this.DateTime,
      required this.comment,
      this.userName = ""});

  Map<String, dynamic> toMap() {
    return {
      'commentType': commentType,
      'postID': postID,
      'DateTime': DateTime,
      'comment': comment,
    };
  }

  factory UserComments.fromMap(Map<String, dynamic> map) {
    return UserComments(
        commentType: map['commentType'],
        postID: map['postID'],
        DateTime: map['DateTime'],
        comment: map['comment'],
        userName: map['userName']);
  }

  String toJson() => json.encode(toMap());

  factory UserComments.fromJson(String source) =>
      UserComments.fromMap(json.decode(source));
}

class Likes {
  String dateTime;
  String eventName;
  String eventID;
  Likes({
    required this.dateTime,
    required this.eventName,
    required this.eventID,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'eventName': eventName,
      'eventID': eventID,
    };
  }

  factory Likes.fromMap(Map<String, dynamic> map) {
    return Likes(
      dateTime: map['dateTime'],
      eventName: map['eventName'],
      eventID: map['eventID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Likes.fromJson(String source) => Likes.fromMap(json.decode(source));
}
