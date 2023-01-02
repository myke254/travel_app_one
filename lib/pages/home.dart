import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_one/pages/bookings_page.dart';
import 'package:travel_app_one/pages/home_page.dart';
import 'package:travel_app_one/pages/settings.dart';
import 'package:travel_app_one/repository/app_localization.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
   int _selectedIndex = 0;
  int _currentTab = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        onPageChanged: ((value) {
          setState(() {
            _currentTab = value;
          });
        }),
        controller: pageController,
        children: [
         const HomePage(),
          const BookingsPage(),
          SettingsPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
          pageController.jumpToPage(value);
        },
        items:const [
           
           BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.orange,
              ),
              label: 'Home'
              // title: SizedBox.shrink(),
              ),
              
           BottomNavigationBarItem(
              icon: Icon(Icons.hotel,color: Colors.orange,size: 30,),
              label: 'My Bookings'
              // title: SizedBox.shrink(),
              ),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.orange,
              ),
              label: 'Settings'
              // title: SizedBox.shrink(),
              ),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}