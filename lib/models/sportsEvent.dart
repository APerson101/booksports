import 'dart:convert';

class SportsEvent {
  int attendance;
  String description;
  String link;
  String location;
  String name;
  String participant;
  String? creatorName;
  int commentCount;
  int likesCount;
  String? eventID;
  String dateTimeCreated;
  List<String> type;
  SportsEvent(
      {required this.attendance,
      required this.description,
      required this.link,
      required this.location,
      required this.name,
      required this.participant,
      this.creatorName = "not done yet",
      required this.type,
      required this.dateTimeCreated,
      this.eventID,
      this.likesCount = 0,
      this.commentCount = 0});

  Map<String, dynamic> toMap() {
    return {
      'attendance': attendance,
      'description': description,
      'link': link,
      'location': location,
      'name': name,
      'participant': participant,
      'creatorName': creatorName,
      'type': type,
      'likesCount': likesCount,
      'commentCount': commentCount,
      'dateTimeCreated': dateTimeCreated
    };
  }

  factory SportsEvent.fromMap(Map<String, dynamic> map) {
    return SportsEvent(
        attendance: map['attendance'],
        description: map['description'],
        link: map['link'],
        location: map['location'],
        name: map['name'],
        participant: map['participant'],
        creatorName: map['creatorName'] == null ? " " : map['creatorName'],
        type: List.from(map['type']),
        likesCount: map["likesCount"],
        commentCount: map["commentCount"],
        eventID: map["eventID"],
        dateTimeCreated: map["dateTimeCreated"]);
  }

  String toJson() => json.encode(toMap());

  factory SportsEvent.fromJson(String source) =>
      SportsEvent.fromMap(json.decode(source));
}
