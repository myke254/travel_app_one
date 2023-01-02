import 'package:cloud_firestore/cloud_firestore.dart';

class Bookings {
  String? bookingId;
  String? customerId;
  String? hotelId;
  Timestamp? arrivalDate;
  Timestamp? departureDate;
  int? adults;
  int? children;
  int? infants;
  String? roomType;
  int? price;
  String? currency;
  String? paymentMethod;
  String? specialRequests;
  String? status;
  Bookings(
      {this.bookingId,
      this.customerId,
      this.hotelId,
      this.arrivalDate,
      this.departureDate,
      this.adults,
      this.children,
      this.infants,
      this.roomType,
      this.price,
      this.currency,
      this.paymentMethod,
      this.specialRequests,
      this.status});

  Bookings.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    customerId = json['customerId'];
    hotelId = json['hotelId'];
    arrivalDate =  json['arrivalDate'];
    departureDate = json['departureDate'];
    adults = json['adults'];
    children = json['children'];
    infants = json['infants'];
    roomType = json['roomType'];
    price = json['price'];
    currency = json['currency'];
    paymentMethod = json['paymentMethod'];
    specialRequests = json['specialRequests'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingId'] = bookingId;
    data['customerId'] = customerId;
    data['hotelId'] = hotelId;
    data['arrivalDate'] = arrivalDate;
    data['departureDate'] = departureDate;
    data['adults'] = adults;
    data['children'] = children;
    data['infants'] = infants;
    data['roomType'] = roomType;
    data['price'] = price;
    data['currency'] = currency;
    data['paymentMethod'] = paymentMethod;
    data['specialRequests'] = specialRequests;
    data['status'] = status;
    return data;
  }
}
