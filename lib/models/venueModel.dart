import 'dart:convert';

class VenueModel {
  String desription;
  List<String> facilities;

  List<String> features;

  String location;
  String name;
  int? rating;

  String? venueID;
  VenueModel(
      {required this.desription,
      required this.facilities,
      required this.features,
      required this.location,
      required this.name,
      this.rating = -1,
      this.venueID = ""});

  Map<String, dynamic> toMap() {
    return {
      'desription': desription,
      'facilities': facilities,
      'features': features,
      'location': location,
      'name': name,
      'rating': rating,
    };
  }

  factory VenueModel.fromMap(Map<String, dynamic> map) {
    return VenueModel(
        desription: map['desription'],
        facilities: List<String>.from(map['facilities']),
        features: List<String>.from(map['features']),
        location: map['location'],
        name: map['name'],
        rating: map['rating'],
        venueID: map['venueID']);
  }

  String toJson() => json.encode(toMap());

  factory VenueModel.fromJson(String source) =>
      VenueModel.fromMap(json.decode(source));
}
