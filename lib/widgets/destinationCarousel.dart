// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_one/models/tourist_destination_model.dart';
import 'package:travel_app_one/pages/all_destinations.dart';
import 'package:travel_app_one/repository/tourist_destinations.dart';

import '../pages/destination_page.dart';

class DestinationCarousel extends StatefulWidget {
   DestinationCarousel({Key? key}) : super(key: key);

  @override
  State<DestinationCarousel> createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TouristDestination>? _destinations;
  Future<List<TouristDestination>> getDestinations()async{
  Future<List<TouristDestination>> futureDestinations;

  futureDestinations =  DestinationsFirestoreCRUD(_firestore.collection('touristDestinations')).fetch();
  _destinations = await futureDestinations;
  setState(() {
    
  });
    return futureDestinations;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Top Destinations',
                style:  TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AllDestinations(destinations: _destinations!)));
                },
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: getDestinations(),
          builder: (context,AsyncSnapshot<List<TouristDestination>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CupertinoActivityIndicator(),);
            }
            List<TouristDestination> touristdestination = snapshot.data!;
            return SizedBox(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:touristdestination.length, //destinations.length,
                  itemBuilder: (BuildContext context, int index) {
                   // Destination destination = destinations[index];
                   TouristDestination destination =touristdestination[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationPage(
                            destination: destination,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: 210.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 15.0,
                              child: Container(
                                height: 120.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${destination.destinationName}',
                                        //'${destination.attractions!.length} Attractions',
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1),
                                      ),
                                      Text(
                                        destination.shortDescription!,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow:const [
                                   BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  )
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: destination.images!.first,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                        height: 180.0,
                                        width: 180.0,
                                        fit: BoxFit.cover, imageUrl: destination.images!.first,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          destination.county!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Icon(FontAwesomeIcons.locationArrow,
                                                size: 10.0, color: Colors.white),
                                            const SizedBox(width: 5.0),
                                            Text(destination.country!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                 )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
          }
        )
      ],
    );
  }
}
