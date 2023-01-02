import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_one/pages/home.dart';
import 'package:travel_app_one/repository/app_localization.dart';
import 'firebase_options.dart';
import 'pages/auth_page.dart';
import 'repository/auth_repository.dart';
import 'repository/language_provider.dart';
// import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MpesaFlutterPlugin.setConsumerKey("pwzzubbS0WPGM8R7LAgeCBrmEECLXmG3");
  MpesaFlutterPlugin.setConsumerSecret("1FW0hF5Kmpczi3Le");
  Provider.debugCheckInvalidValueType = null;
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
   final CurrentData currentData = CurrentData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
    ChangeNotifierProvider(
        create: (context) => currentData),
    ChangeNotifierProvider(
        create: (context) =>
            AuthRepository.instance(firestore: FirebaseFirestore.instance))
  ],
        child: Consumer<CurrentData>(
          builder: (context,provider,child) {
            return MaterialApp(
                localizationsDelegates: const [
                     AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                   Locale('en'),
                   Locale('fr'),
                   Locale('es'),
                   Locale('ru'),
                ],
                locale: Provider.of<CurrentData>(context).locale,
                title: 'Coastal Region Tourist Guide',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  textTheme: TextTheme(
                    bodyText1: GoogleFonts.varelaRound(),
                    bodyText2: GoogleFonts.varelaRound(),
                    button: GoogleFonts.varelaRound(),
                  ),
                  primaryColor: Colors.orangeAccent[700],
                  primarySwatch: Colors.teal,
                  scaffoldBackgroundColor: Colors.blue[100],
                ),
                home: Consumer(builder: (context, AuthRepository auth, _) {
                  switch (auth.status) {
                    case Status.unauthenticated:
                    case Status.authenticating:
                      return const AuthPage();
                    case Status.verifying:
                      return const AuthPage();
                    default:
                      return const Home();
                  }
                }));
          }
        )
      
    );
  }
}
