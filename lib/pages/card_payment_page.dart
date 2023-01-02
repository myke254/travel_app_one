import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/hotel_model.dart';
import 'package:travel_app_one/pages/bookings_page.dart';

import '../models/bookings_model.dart';
import '../repository/book_room.dart';

class CardPaymentPage extends StatefulWidget {
  const CardPaymentPage(
      {super.key,
      required this.roomType,
      required this.hotel,
      required this.adults,
      required this.daysBooked,
      required this.specialRequests,
      required this.arrivalDate,
      required this.departureDate});
  final RoomTypes roomType;
  final HotelModel hotel;
  final int adults, daysBooked;
  final String specialRequests;
  final DateTime arrivalDate, departureDate;

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expMonthController = TextEditingController();
  final _expYearController = TextEditingController();
  final _cvcController = TextEditingController();
  Bookings bookings() {
    return Bookings.fromJson({
      'bookingId': '',
      'customerId': FirebaseAuth.instance.currentUser!.uid,
      'hotelId': widget.hotel.id,
      'arrivalDate': Timestamp.fromDate(widget.arrivalDate),
      'departureDate': Timestamp.fromDate(widget.departureDate),
      'adults': widget.adults,
      'children': 0,
      'infants': 0,
      'roomType': widget.roomType.title!,
      'price': (widget.roomType.price! * widget.daysBooked),
      'currency': 'Kes',
      'paymentMethod': 'Visa',
      'specialRequests': widget.specialRequests,
      'status': 'confirmed',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Image.asset(
            'assets/images/visa.png',
            height: 50,
          ),
          elevation: 0,
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 13, 161, 75),
                            Color.fromARGB(255, 14, 143, 134)
                          ],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0.94, -1),
                          end: AlignmentDirectional(-0.94, 1),
                        ),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Card number
                              TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontSize: 21),
                                controller: _cardNumberController,
                                decoration: const InputDecoration(
                                  labelText: 'Card number',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your card number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              // Expiration date
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _expMonthController,
                                      decoration: const InputDecoration(
                                        labelText: 'Expiration month',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your card expiration month';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _expYearController,
                                      decoration: const InputDecoration(
                                        labelText: 'Expiration year',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your card expiration year';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              // CVC
                              TextFormField(
                                controller: _cvcController,
                                decoration: const InputDecoration(
                                  labelText: 'CVV',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your card CVC';
                                  }
                                  return null;
                                },
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Pay button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21)),
                            minimumSize: const Size(200, 70)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process payment
                            BookRoom.instance(bookings(),
                                    firestore: FirebaseFirestore.instance)
                                .bookRoom()
                                .then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BookingsPage()));
                              //return null;
                            });
                          }
                        },
                        child: const Text(
                          'Pay',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ))
                  ],
                ))));
  }
}
