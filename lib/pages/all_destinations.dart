import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/tourist_destination_model.dart';

import 'destination_page.dart';

class AllDestinations extends StatelessWidget {
  const AllDestinations({Key? key, required this.destinations}) : super(key: key);
  final List<TouristDestination> destinations;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,
        title: const Text('Top Destinations',style: TextStyle(color: Colors.black),),
      ),
      body: ListView(children: destinations.map((destination){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationPage(
                            destination: destination,
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
                                                Text(destination.destinationName!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                Text('${destination.county},${destination.country}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                                // Text('from: ${booking.arrivalDate!.toDate().toString().substring(0,10)}'),
                                                // Text('to: ${booking.departureDate!.toDate().toString().substring(0,10)}'),
                                                
                                                 SizedBox(
                                                  width: 150,
                                                  child: Text('${destination.shortDescription}',textAlign: TextAlign.justify,style: const TextStyle(fontWeight: FontWeight.w100,fontSize: 10),))
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
                                  child: CachedNetworkImage(imageUrl: destination.images!.first,height: 100,width: 150,fit: BoxFit.fill,),
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