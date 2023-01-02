import 'package:cloud_firestore/cloud_firestore.dart';

class TouristDestination {
  final List<String>? images;
  final String? destinationName;
  final GeoPoint? location;
  final String? description;
  final String? shortDescription;
  final List<Attraction>? attractions;
  final String? id;
  final String? country;
  final String? county;

  TouristDestination({
    this.images,
     this.destinationName,
     this.location,
     this.description,
     this.attractions,
     this.id,
     this.country,
     this.county,
     this.shortDescription
  });

  factory TouristDestination.fromJson(Map<String, dynamic> json) {
    return TouristDestination(
      images: List<String>.from(json['images']),
      destinationName: json['destinationName'] as String,
      location: json['location'] as GeoPoint,
      description: json['description'] as String,
      attractions: List<Attraction>.from(
        json['attractions'].map((attraction) => Attraction.fromJson(attraction)),
      ),
      id: json['id'] as String,
      country: json['country'] as String,
      county: json['county'] as String,
      shortDescription: json['shortDescription'] as String,
    );
  }
}

class Attraction {
  final String? title;
  final List<String>? images;
  final String? id;
  final String? description;

  Attraction({
     this.title,
     this.images,
     this.id,
     this.description
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      title: json['title'] as String,
      description: json['description'],
      images: List<String>.from(json['images']),
      id: json['id'] as String
    );
  }
}
