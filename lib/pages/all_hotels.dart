import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/hotel_model.dart';

import 'hotel_page.dart';

class AllHotels extends StatelessWidget {
  const AllHotels({Key? key, required this.hotels}) : super(key: key);
  final List<HotelModel> hotels;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,
        title: const Text('Top Hotels',style: TextStyle(color: Colors.black),),
      ),
      body: ListView(children: hotels.map((hotel){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HotelPage(
                            hotel: hotel,
                           // destination: destination,
                          ),
                        ),
                      );
            },
            child: SizedBox(
              width:MediaQuery.of(context).size.width,
                 height: 130,
              child: Stack(
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
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(hotel.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                Text('starting at ksh ${hotel.rates}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                                // Text('from: ${booking.arrivalDate!.toDate().toString().substring(0,10)}'),
                                                // Text('to: ${booking.departureDate!.toDate().toString().substring(0,10)}'),
                                                
                                                 SizedBox(
                                                  width: 150,
                                                  child: Text('${hotel.amenities}',textAlign: TextAlign.justify,style: const TextStyle(fontWeight: FontWeight.w100,fontSize: 10),))
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
                                  child: CachedNetworkImage(imageUrl: hotel.image!,height: 100,width: 150,fit: BoxFit.fill,),
                                ),
                              )
                            ],
                          ),
            ),
          ),
        );
      }).toList(),),
    );
  }
}