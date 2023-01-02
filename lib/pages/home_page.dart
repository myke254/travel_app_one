import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_one/models/user_model.dart';
import 'package:travel_app_one/repository/app_localization.dart';
import 'package:travel_app_one/repository/user.dart';
import 'package:travel_app_one/widgets/restaurant_carousel.dart';

import '../repository/auth_repository.dart';
import '../widgets/destinationCarousel.dart';
import '../widgets/hotelCarousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {



    late AuthRepository auth;
  final List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.personWalking,
    FontAwesomeIcons.personBiking,
  ];

  // Widget _buildIcon(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       //auth.signOut();
  //       setState(() {
  //         _selectedIndex = index;
  //       });
       
  //     },
  //     child: Container(
  //       height: 60.0,
  //       width: 60.0,
  //       decoration: BoxDecoration(
  //         color: _selectedIndex == index
  //             ? Theme.of(context).accentColor
  //             : Colors.grey[350],
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //       child: Icon(
  //         _icons[index],
  //         size: 25.0,
  //         color: _selectedIndex == index
  //             ? Theme.of(context).primaryColor
  //             : Colors.deepOrange[400],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    auth = Provider.of<AuthRepository>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: ListView(
            children: <Widget>[
             const  Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom: 30),
                child: Text('Coastal Region tourist Guide',
                    style:  TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
             
             FutureBuilder(
              future: UserFirestoreCRUD(FirebaseFirestore.instance.collection('users')).read(auth.user.uid),
               builder: (context,AsyncSnapshot<UserModel?> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                 return Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Text('Hello ${snapshot.data?.name??''}',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange
                    )),
                 );
               }
             ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: _icons
              //       .asMap()
              //       .entries
              //       .map(
              //         (MapEntry map) => _buildIcon(map.key),
              //       )
              //       .toList(),
              // ),
              const SizedBox(height: 20.0),
              DestinationCarousel(),
              const SizedBox(height: 20.0),
              HotelCarousel(),
              const SizedBox(height: 20.0),
              const RestaurantCarousel(),
            ],
          ),
        ),
      ),
      
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
