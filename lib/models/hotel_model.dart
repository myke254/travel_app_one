import 'package:cloud_firestore/cloud_firestore.dart';

class HotelModel {
  String? name;
  List<RoomTypes>? roomTypes;
  GeoPoint? location;
  ContactInformation? contactInformation;
  String? id;
  String? amenities;
  int? rates;
  String? image;

  HotelModel(
      {this.name,
      this.roomTypes,
      this.location,
      this.contactInformation,
      this.id,
      this.amenities,
      this.rates,
      this.image});

  HotelModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['roomTypes'] != null) {
      roomTypes = <RoomTypes>[];
      json['roomTypes'].forEach((v) {
        roomTypes!.add(new RoomTypes.fromJson(v));
      });
    }
    location = json['location'];
    contactInformation = json['contactInformation'] != null
        ? new ContactInformation.fromJson(json['contactInformation'])
        : null;
    id = json['id'];
    amenities = json['amenities'];
    rates = json['rates'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.roomTypes != null) {
      data['roomTypes'] = this.roomTypes!.map((v) => v.toJson()).toList();
    }
    data['location'] = this.location;
    if (this.contactInformation != null) {
      data['contactInformation'] = this.contactInformation!.toJson();
    }
    data['id'] = this.id;
    data['amenities'] = this.amenities;
    data['rates'] = this.rates;
    data['image'] = this.image;
    return data;
  }
}

class RoomTypes {
  String? currency;
  int? beds;
  String? description;
  String? title;
  int? price;
  String? image;

  RoomTypes(
      {this.currency, this.beds, this.description, this.title, this.price});

  RoomTypes.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    beds = json['beds'];
    description = json['description'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['beds'] = this.beds;
    data['description'] = this.description;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image'] = image;
    return data;
  }
}

class ContactInformation {
  List<String>? phone;
  List<String>? email;

  ContactInformation({this.phone, this.email});

  ContactInformation.fromJson(Map<String, dynamic> json) {
    phone = json['phone'].cast<String>();
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
