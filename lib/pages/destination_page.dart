import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_one/models/tourist_destination_model.dart';

import '../models/activities.dart';
import '../models/destination.dart';

class DestinationPage extends StatefulWidget {
  final TouristDestination? destination;

  const DestinationPage({Key? key, this.destination}) : super(key: key);
  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐';
  }
  stars.trim();
  return Text(stars);
}
ScrollController controller = ScrollController();
class _DestinationPageState extends State<DestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width-80  ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow:const [
                   BoxShadow(
                      color: Colors.black26,
                      offset:  Offset(0.0, 2.0),
                      blurRadius: 6.0)
                ],
              ),
              child: Hero(
                tag: widget.destination?.images?.first ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                      imageUrl: widget.destination?.images?.first ?? '',
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.search),
                        iconSize: 30.0,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.sortAmountDown),
                        iconSize: 25.0,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: 20.0,
              bottom: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.destination!.county!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.locationArrow,
                          size: 15.0, color: Colors.white70),
                      const SizedBox(width: 5.0),
                      Text(widget.destination!.country!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 20.0,
              right: 20.0,
              child: Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 25.0,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
                                          '${widget.destination!.destinationName}',
                                          //'${destination.attractions!.length} Attractions',
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1),
                                        ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
           // height: 300,
            width: double.infinity,
            //color: Colors.amber,
            constraints: const BoxConstraints(maxHeight: 200).tighten(),
            child: Scrollbar(
              thumbVisibility: true,
              controller: controller,
              child: SingleChildScrollView(
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.destination!.description!,textAlign: TextAlign.justify,style: const TextStyle(fontWeight: FontWeight.w100,letterSpacing: 2,wordSpacing: 2,fontSize: 15),),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
            itemCount: widget.destination!.attractions!.length,
            itemBuilder: (BuildContext context, int index) {
              Attraction activity = widget.destination!.attractions![index];
              return Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                    height: 130.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            activity.title!,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(activity.description!,style: const TextStyle(
                              fontSize: 12.0,
                              
                            ),
                          
                           )
                          // Text(
                          //   activity.type!,
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          // _buildRatingStars(activity.rating!),
                          // SizedBox(height: 10.0),
                          // Row(
                          //   children: <Widget>[
                          //     Container(
                          //       padding: EdgeInsets.all(5.0),
                          //       width: 70.0,
                          //       decoration: BoxDecoration(
                          //         color: Theme.of(context).accentColor,
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       ),
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         activity.startTimes![0],
                          //       ),
                          //     ),
                          //     SizedBox(width: 10.0),
                          //     Container(
                          //       padding: EdgeInsets.all(5.0),
                          //       width: 70.0,
                          //       decoration: BoxDecoration(
                          //         color: Theme.of(context).accentColor,
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       ),
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         activity.startTimes![1],
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    top: 15.0,
                    bottom: 15.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        width: 110.0,
                        imageUrl: (activity.images?.first ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    ));
  }
}
