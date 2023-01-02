import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app_one/models/user_model.dart';

import '../models/restaurant_model.dart';
import 'firestore_crud.dart';

class UserFirestoreCRUD extends FirestoreCRUD<UserModel> {
  UserFirestoreCRUD(CollectionReference collection) : super(collection);
   @override
  UserModel fromMap(DocumentSnapshot<Object?> snapshot) {
    var model = UserModel.fromJson(snapshot.data() as Map<String,dynamic>);
    return model;
  }
  @override
  Future<UserModel?> read(String id) {
    return super.read(id);
  }
  
}