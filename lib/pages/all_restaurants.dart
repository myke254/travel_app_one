import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/models/restaurant_model.dart';
import 'package:travel_app_one/pages/restaurant_page.dart';


class AllRestaurants extends StatelessWidget {
  const AllRestaurants({Key? key, required this.restaurant}) : super(key: key);
  final List<Restaurant> restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,
        title: const Text('Top Restaurants',style: TextStyle(color: Colors.black),),
      ),
      body: ListView(children: restaurant.map((restaurant){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
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
                                                Text(restaurant.name!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                Text('${restaurant.cuisine} cuisine',style: const TextStyle(fontWeight: FontWeight.bold),),
                                                Text('${restaurant.phone}',textAlign: TextAlign.justify,style: const TextStyle(fontWeight: FontWeight.w100,fontSize: 10),),
                                                // Text('from: ${booking.arrivalDate!.toDate().toString().substring(0,10)}'),
                                                // Text('to: ${booking.departureDate!.toDate().toString().substring(0,10)}'),
                                                
                                                 SizedBox(
                                                  width: 150,
                                                  child: Text('${restaurant.address}',textAlign: TextAlign.justify,style: const TextStyle(fontWeight: FontWeight.w100,fontSize: 10),))
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
                                  child: CachedNetworkImage(imageUrl: restaurant.photos!.first,height: 100,width: 150,fit: BoxFit.fill,),
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