import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/bookings_model.dart';
import 'package:travel_app_one/models/hotel_model.dart';
import 'package:travel_app_one/pages/hotel_page.dart';
import 'package:travel_app_one/repository/book_room.dart';
import 'package:travel_app_one/repository/mpesa.dart';

import '../pages/bookings_page.dart';

class MpesaDialog extends StatelessWidget {
  MpesaDialog({
    Key? key,
    required this.roomType,
    required this.widget,
    required this.daysBooked, required this.arrivalDate, required this.departureDate, required this.adults, this.specialRequests ='',
  }) : super(key: key);
  final String specialRequests;
  final RoomTypes? roomType;
 final DateTime arrivalDate,departureDate;
  final HotelPage widget;
  final int daysBooked,adults;
  final TextEditingController phoneController = TextEditingController();
  bool phoneValid(phone) {
    return RegExp(
            r"^(?:254|\+254|0)?([17](?:(?:[0129][0-9])|(?:4[0-8])|(?:5[7-9])|(?:6[8-9]))[0-9]{6})$")
        .hasMatch(phone);
  }
  Bookings bookings(){
    return Bookings.fromJson({
      'bookingId':'',
       'customerId':FirebaseAuth.instance.currentUser!.uid,
       'hotelId':widget.hotel.id,
       'arrivalDate':Timestamp.fromDate(arrivalDate),
       'departureDate':Timestamp.fromDate(departureDate),
       'adults':adults,
       'children':0,
       'infants':0,
       'roomType':roomType!.title!,
       'price':(roomType!.price! * daysBooked),
       'currency':'Kes',
       'paymentMethod':'Mpesa',
       'specialRequests':specialRequests,
       'status':'confirmed',
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset(
        'assets/images/mpesa.png',
        height: 50,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirm booking of ${roomType!.title!} room in ${widget.hotel.name}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(),
            Text(
              """pay ksh ${roomType!.price! * daysBooked} now to book a ${roomType!.title!} 
              room in ${widget.hotel.name} for $daysBooked night${daysBooked > 1 ? 's' : ''}""",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              onChanged: (text) {
                if (text.startsWith("0")) {
                  try {
                    phoneController.value = phoneController.value.copyWith(
                      text: text.substring(1),
                      selection: const TextSelection.collapsed(offset: 1),
                    );
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                }
              },
              validator: ((val) {
                String phoneNumber = val!.startsWith('0')
                    ? '${val.replaceFirst('0', '254')}}'
                    : '254$val';
                return phoneValid(phoneNumber) ? null : 'invalid phone number';
              }),
              decoration: InputDecoration(
                prefix: const Text('+254'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Enter your phone number',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CANCEL')),
        TextButton(
            onPressed: () {
              String phoneNumber = phoneController.text.startsWith('0')
                  ? '${phoneController.text.replaceFirst('0', '254')}}'
                  : '254${phoneController.text}';
              //print(phoneNumber);
              if (_formKey.currentState!.validate()) {
                Mpesa()
                    .startCheckout(
                        userPhone: phoneNumber,
                        amount: double.parse(
                            (roomType!.price! * daysBooked).toString()))
                    .then((value) {
                      
                       BookRoom.instance(bookings(), firestore: FirebaseFirestore.instance).bookRoom().then((value) {
                        Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BookingsPage()));
                       });
                    });
              } else {}
            },
            child: const Text('PAY NOW'))
      ],
    );
  }
}
