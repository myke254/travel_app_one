import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app_one/models/tourist_destination_model.dart';

import 'firestore_crud.dart';

class DestinationsFirestoreCRUD extends FirestoreCRUD<TouristDestination> {
  DestinationsFirestoreCRUD(CollectionReference collection) : super(collection);
  
   @override
  TouristDestination fromMap(DocumentSnapshot<Object?> snapshot) {
    var model = TouristDestination.fromJson(snapshot.data() as Map<String,dynamic>);
    return model;
  }
  Future<List<TouristDestination>> fetch() async {
    final querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) => fromMap(doc)).toList();
  }
  
}