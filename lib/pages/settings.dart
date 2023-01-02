import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_one/models/user_model.dart';
import 'package:travel_app_one/repository/language_provider.dart';
import 'package:travel_app_one/repository/user.dart';

import '../repository/auth_repository.dart';
import '../repository/constants.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final DefaultData defaultData = DefaultData();
  late AuthRepository auth;
  Future<UserModel?> getUserName() async {
    return UserFirestoreCRUD(FirebaseFirestore.instance.collection('users'))
        .read(auth.user.uid);
  }

  Future signOutDialog(BuildContext context) {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm LogOut'),
            content: const Text('Do you really want to LogOut?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('STAY')),
              TextButton(
                  onPressed: () => auth.signOut().then((value) => Navigator.pop(context)), child: const Text('LOGOUT'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthRepository>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getUserName(),
                builder: (context, AsyncSnapshot<UserModel?> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Container(
                            margin: EdgeInsets.zero,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white,),
                            child:const Icon(
                              Icons.account_circle_sharp,
                              size: 90,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(snapshot.data?.name ?? 'User',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                const SizedBox(height: 10,),
                                Text('${snapshot.data?.email}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          )
                        ],
                      ),
                      ElevatedButton.icon(
                          onPressed:()=> signOutDialog(context),
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'))
                    ],
                  );
                }),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle switch change
                },
              ),
            ),
          ),
          Consumer<CurrentData>(builder: (context, currentData, child) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                  'Language',
                  locale: currentData.locale,
                ),
                subtitle:
                    Text('Current selected language: ${currentData.locale}'),
                trailing: DropdownButton<String>(
                  value: currentData.defineCurrentLanguage(context),
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.teal,
                  ),
                  iconSize: 20,
                  elevation: 0,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 1,
                  ),
                  dropdownColor: Colors.indigo,
                  onChanged: (newValue) {
                    currentData.changeLocale(newValue.toString());
                  },
                  items: defaultData.languagesListDefault
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          }),
          Card(
            child: ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Handle switch change
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
