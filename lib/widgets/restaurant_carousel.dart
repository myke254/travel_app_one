// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/restaurant_model.dart';
import 'package:travel_app_one/pages/all_restaurants.dart';
import 'package:travel_app_one/pages/restaurant_page.dart';
import 'package:travel_app_one/repository/restaurants.dart';

class RestaurantCarousel extends StatefulWidget {
  const RestaurantCarousel({Key? key}) : super(key: key);

  @override
  State<RestaurantCarousel> createState() => _RestaurantCarouselState();
}

class _RestaurantCarouselState extends State<RestaurantCarousel> {
      List<Restaurant>? _restaurant;
  Future<List<Restaurant>> getRestaurants()async{
  Future<List<Restaurant>> futureHotels;

  futureHotels =  RestaurantFirestoreCRUD(FirebaseFirestore.instance.collection('restaurants')).fetch();
  _restaurant = await futureHotels;
  setState(() {
    
  });
    return futureHotels;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Exclusive Restaurants',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AllRestaurants(
                            restaurant: _restaurant!,
                           // destination: destination,
                          ),
                        ),
                      ),
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
          future: getRestaurants(),
          builder: (context,AsyncSnapshot<List<Restaurant>>  snapshot){
             if(!snapshot.hasData){
                return const Center(child: CupertinoActivityIndicator(),);
                }
                 List<Restaurant> restaurants = snapshot.data!;
                 return SizedBox(
                    height: 300.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurants.length,
                      itemBuilder: (BuildContext context, int index) {
                        Restaurant restaurant = restaurants[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RestaurantPage(
                                restaurant: restaurant,
                               // destination: destination,
                              ),
                            ),
                          );
                          },
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            restaurant.name!,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1),
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
                                          Text('${restaurant.cuisine} cuisine',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                              const SizedBox(height: 5,),
                                              Text('${restaurant.address}',
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w100,
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
                                      imageUrl: (restaurant.photos?.first??''),
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
        }),
      ],
    );
  }
}