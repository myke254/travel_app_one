import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/restaurant_model.dart';
import 'firestore_crud.dart';

class RestaurantFirestoreCRUD extends FirestoreCRUD<Restaurant> {
  RestaurantFirestoreCRUD(CollectionReference collection) : super(collection);
  
   @override
  Restaurant fromMap(DocumentSnapshot<Object?> snapshot) {
    var model = Restaurant.fromJson(snapshot.data() as Map<String,dynamic>);
    return model;
  }
  Future<List<Restaurant>> fetch() async {
    final querySnapshot = await collection.get();
    return querySnapshot.docs.map((doc) => fromMap(doc)).toList();
  }
  
}