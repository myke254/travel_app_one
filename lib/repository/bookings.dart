import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app_one/models/bookings_model.dart';

import 'firestore_crud.dart';

class BookingFirestoreCRUD extends FirestoreCRUD<Bookings> {
  BookingFirestoreCRUD(CollectionReference collection) : super(collection);
  final User? user = FirebaseAuth.instance.currentUser;
   @override
  Bookings fromMap(DocumentSnapshot<Object?> snapshot) {
    var model = Bookings.fromJson(snapshot.data() as Map<String,dynamic>);
    return model;
  }
  Future<List<Bookings>> fetch(String status) async {
    final querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) => fromMap(doc)).where((booking) => booking.customerId == user!.uid).where((booking) => booking.status ==status).toList();
  }
  
}