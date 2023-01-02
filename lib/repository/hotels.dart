import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app_one/models/hotel_model.dart';

import 'firestore_crud.dart';

class HotelFirestoreCRUD extends FirestoreCRUD<HotelModel> {
  HotelFirestoreCRUD(CollectionReference collection) : super(collection);
  
   @override
  HotelModel fromMap(DocumentSnapshot<Object?> snapshot) {
    var model = HotelModel.fromJson(snapshot.data() as Map<String,dynamic>);
    return model;
  }
  @override
  Future<HotelModel?> read(String id) {
    return super.read(id);
  }
  Future<List<HotelModel>> fetch() async {
    final querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) => fromMap(doc)).toList();
  }
  
}