import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_one/models/hotel_model.dart';
import 'package:travel_app_one/pages/card_payment_page.dart';
import 'package:travel_app_one/widgets/mpesa_dialog.dart';

import '../models/bookings_model.dart';
import '../repository/book_room.dart';
import 'bookings_page.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({Key? key, required this.hotel}) : super(key: key);
  final HotelModel hotel;
  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  String? _specialRequests;
  int _numberOfPeople = 1;
  RoomTypes? roomType;
  String? _paymentMethod = 'mpesa';
  bool _payNow = true;
  List<DropdownMenuItem<int>> dropDownItems() {
    return List.generate(
        roomType?.beds ?? 0,
        (index) => DropdownMenuItem(
            value: index + 1, child: Text((index + 1).toString())));
  }

  int daysBooked() {
    int days = (_checkOutDate?.difference(_checkInDate!).inDays)?.abs() ?? 0;
    return days == 0 ? 1 : days;
  }

  Bookings bookings() {
    return Bookings.fromJson({
      'bookingId': '',
      'customerId': FirebaseAuth.instance.currentUser!.uid,
      'hotelId': widget.hotel.id,
      'arrivalDate': Timestamp.fromDate(_checkInDate!),
      'departureDate': Timestamp.fromDate(_checkOutDate!),
      'adults': _numberOfPeople,
      'children': 0,
      'infants': 0,
      'roomType': roomType!.title!,
      'price': (roomType!.price! * daysBooked()),
      'currency': 'Kes',
      'paymentMethod': 'not set',
      'specialRequests': _specialRequests,
      'status': 'pending',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.hotel.image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.hotel.name!,
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${widget.hotel.name!}\n\n${widget.hotel.amenities!}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1),
                )),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Available rooms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 246,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.hotel.roomTypes!
                      .map((room) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  roomType = room;
                                });
                              },
                              child: SizedBox(
                                height: 230,
                                width: 200,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 130,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 60,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8, left: 8),
                                              child: Text(
                                                room.description!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8, left: 8, bottom: 5),
                                              child: Text(
                                                'ksh ${room.price!}.00 per night',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: SizedBox(
                                            height: 160,
                                            width: 180,
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: room.image!,
                                                  height: 160,
                                                  width: 180,
                                                  fit: BoxFit.cover,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    room.title!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                    Visibility(
                                      visible: (roomType != null &&
                                          (roomType?.title ?? '') ==
                                              room.title),
                                      child: Card(
                                        color: Colors.pink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Visibility(
              visible: roomType != null,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                        backgroundColor: Colors.pink,
                        label: Text(
                          roomType?.title ?? 'No hotel room selected',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  Visibility(
                    visible: _checkInDate != null && _checkOutDate != null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                          backgroundColor: Colors.amber,
                          label: Text(
                            "${daysBooked()} night${daysBooked() == 1 ? '' : 's'}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: roomType != null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _checkInDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != _checkInDate) {
                          if (_checkOutDate != null) {
                            if (_checkInDate?.compareTo(picked).isNegative ??
                                false) {
                              setState(() {
                                _checkOutDate = null;
                              });
                            }
                          }
                          setState(() {
                            _checkInDate = picked;
                          });
                        }
                      },
                      child: Text(
                        _checkInDate == null
                            ? 'Select check-in date'
                            : DateFormat.yMd().format(_checkInDate!),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Visibility(
                      visible: _checkInDate != null,
                      child: TextButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _checkInDate!,
                            firstDate: _checkInDate!,
                            lastDate: DateTime(2025),
                          );
                          if (picked != null && picked != _checkOutDate) {
                            setState(() {
                              _checkOutDate = picked;
                            });
                          }
                        },
                        child: Text(
                          _checkOutDate == null
                              ? 'Select check-out date'
                              : DateFormat.yMd().format(_checkOutDate!),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Special requests (optional)',
                ),
                onChanged: (value) {
                  setState(() {
                    _specialRequests = value;
                  });
                },
              ),
            ),
            Visibility(
              visible: roomType != null &&
                  (_checkInDate != null && _checkOutDate != null),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.bold),
                          dropdownColor: Colors.white,
                          value: _numberOfPeople,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Number of people',
                          ),
                          items: dropDownItems(),
                          onChanged: (value) {
                            setState(() {
                              _numberOfPeople = int.parse(value.toString());
                            });
                          })),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pay now or pay later',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RadioListTile(
                          activeColor: Colors.blue,
                          title: const Text('Pay now'),
                          value: true,
                          groupValue: _payNow,
                          onChanged: (value) {
                            setState(() {
                              _payNow = value as bool;
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: Colors.blue,
                          title: const Text('Pay later'),
                          value: false,
                          groupValue: _payNow,
                          onChanged: (value) {
                            setState(() {
                              _payNow = value as bool;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _payNow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment method',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RadioListTile(
                            activeColor: Colors.green,
                            title: Image.asset(
                              'assets/images/mpesa.png',
                              width: 90,
                              height: 40,
                              fit: BoxFit.fitHeight,
                            ),
                            value: 'mpesa',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Colors.blue,
                            title: Image.asset(
                              'assets/images/visa.png',
                              width: 90,
                              height: 60,
                              fit: BoxFit.fitHeight,
                            ),
                            value: 'credit_card',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Visibility(
          visible: roomType != null && _checkOutDate != null,
          child: InkWell(
            onTap: () {
              if (_paymentMethod == 'credit_card' && _payNow) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CardPaymentPage(
                              adults: _numberOfPeople,
                              arrivalDate: _checkInDate!,
                              daysBooked: daysBooked(),
                              departureDate: _checkOutDate!,
                              hotel: widget.hotel,
                              roomType: roomType!,
                              specialRequests: _specialRequests ?? '',
                            )));
              } else if (_paymentMethod == 'mpesa' && _payNow) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MpesaDialog(
                        roomType: roomType,
                        widget: widget,
                        specialRequests: _specialRequests ?? '',
                        daysBooked: daysBooked(),
                        adults: _numberOfPeople,
                        arrivalDate: _checkInDate!,
                        departureDate: _checkOutDate!,
                      );
                    });
              } else {
                //  Fluttertoast.showToast(msg: 'works');
                BookRoom.instance(bookings(),
                        firestore: FirebaseFirestore.instance)
                    .bookRoom()
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookingsPage())).then(
                      (value) => Fluttertoast.showToast(
                          msg:
                              'Check the pending filter to view this booking'));
                });
              }
            },
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: const Center(
                child: Text(
                  'BOOK NOW',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )),
    );
  }
}
