import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/hotel_model.dart';
import 'package:travel_app_one/pages/all_hotels.dart';
import 'package:travel_app_one/pages/hotel_page.dart';
import 'package:travel_app_one/repository/hotels.dart';
//import 'package:travel_app_one/models/hotels.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:travel_app/models/destination.dart';

class HotelCarousel extends StatefulWidget {
  const HotelCarousel({Key? key}) : super(key: key);

  @override
  State<HotelCarousel> createState() => _HotelCarouselState();
}

class _HotelCarouselState extends State<HotelCarousel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    List<HotelModel>? _hotels;
  Future<List<HotelModel>> getHotels()async{
  Future<List<HotelModel>> futureHotels;

  futureHotels =  HotelFirestoreCRUD(_firestore.collection('hotels')).fetch();
  _hotels = await futureHotels;
  setState(() {
    
  });
    return futureHotels;
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
                'Exclusive hotels',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AllHotels(hotels: _hotels!)));
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
          future: getHotels(),
          builder: (context,AsyncSnapshot<List<HotelModel>> snapshot) {
            if(!snapshot.hasData){
            return const Center(child: CupertinoActivityIndicator(),);
            }
             List<HotelModel> hotels = snapshot.data!;
            return SizedBox(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hotels.length,
                  itemBuilder: (BuildContext context, int index) {
                    HotelModel hotel = hotels[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HotelPage(
                            hotel: hotel,
                           // destination: destination,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: 240.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 15.0,
                              child: Container(
                                height: 120.0,
                                width: 240.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        hotel.name!,
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2),
                                      ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      // Text(
                                      //   hotel.address!,
                                      //   style: TextStyle(color: Colors.grey),
                                      // ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('from Ksh ${hotel.rates} / night',
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          )),
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
                                    offset:  Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                  height: 180.0,
                                  width: 220.0,
                                  imageUrl: (hotel.image??''),
                                  fit: BoxFit.cover,
                                ),
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
