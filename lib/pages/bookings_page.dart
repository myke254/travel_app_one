import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app_one/models/bookings_model.dart';
import 'package:travel_app_one/repository/bookings.dart';
import 'package:travel_app_one/repository/hotels.dart';

import '../models/hotel_model.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> with AutomaticKeepAliveClientMixin {
  String status = 'confirmed';
  late Future<List<Bookings>> _bookings;

  Future<List<Bookings>> fetchBookings()async{
    _bookings = BookingFirestoreCRUD(FirebaseFirestore.instance.collection('hotelBookings')).fetch(status);
    return _bookings;
  }
  void refreshData()async{
    setState(() {
      _bookings = fetchBookings();
    });
  }
  @override
  void initState() {
    fetchBookings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:const Text('My Bookings',style: TextStyle(fontSize: 30,color: Colors.orange,shadows: [
      Shadow(
        blurRadius: 2.0,
        color: Colors.black,
        offset: Offset(1.0, 1.0),
      ),
    ],),),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          value: status,
        icon:const Icon(Icons.filter_list),
        items: const [
        DropdownMenuItem(
          value: 'confirmed',
          child: Text('Confirmed')),
          DropdownMenuItem(
          value: 'pending',
          child: Text('Pending')),
    ], onChanged: (value){
      setState(() {
        status = value.toString();
      });
      refreshData();
    }),
      )],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
           refreshData();
        },
        child: FutureBuilder(
          future: _bookings,
          builder: ((context,AsyncSnapshot<List<Bookings>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child:  CupertinoActivityIndicator());
          }
          List<Bookings> bookings = snapshot.data!;//.where((booking) => booking.customerId == FirebaseAuth.instance.currentUser!.uid).toList();
          //Fluttertoast.showToast(msg: bookings.first.roomType!);
          if(bookings.isEmpty){
            return const Center(child: Text('No Bookings Found'),);
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: bookings.map((booking) => SizedBox(
               
                width:MediaQuery.of(context).size.width,
               height: 130,
                child: FutureBuilder(
                        future: HotelFirestoreCRUD(FirebaseFirestore.instance.collection('hotels')).read(booking.hotelId!),
                        builder: (context,AsyncSnapshot<HotelModel?> snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }
                           
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width-120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                            ),
                             height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                     const SizedBox(width: 50,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(snapshot.data!.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                          Text('Room type: ${booking.roomType!}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                          Text('from: ${booking.arrivalDate!.toDate().toString().substring(0,10)}'),
                                          Text('to: ${booking.departureDate!.toDate().toString().substring(0,10)}'),
                                          Text('status: ${booking.status!}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                           Text('payment method: ${booking.paymentMethod!}',style: const TextStyle(fontWeight: FontWeight.w100),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(imageUrl: snapshot.data!.image!,height: 100,width: 150,fit: BoxFit.fill,),
                          ),
                        )
                      ],
                    );
                  }
                ),
              )).toList(),
            ),
          );
        })),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
