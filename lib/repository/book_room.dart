import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app_one/models/bookings_model.dart';

class BookRoom{
   final FirebaseFirestore firestore;
   final Bookings bookingModel;
  BookRoom.instance(this.bookingModel, {required this.firestore,book});
   
 Future<bool> bookRoom()async{
   return await firestore.collection('hotelBookings').add(
     bookingModel.toJson()
    ).then((value) {
      value.update({'bookingId':value.id});
      return true;
    });
  }
}