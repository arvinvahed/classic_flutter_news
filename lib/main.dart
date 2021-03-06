import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/home_provider.dart';
import 'providers/details_provider.dart';
import 'ui/splash.dart';
import 'helper/constants.dart';
import 'ui_user/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var messaging =  FirebaseMessaging.instance;
  var token = await messaging.getToken();
  print('user token is : $token');


  FirebaseMessaging.onMessage.listen((event) {
    print("message recived");
   });


  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("message Cliced");
   });


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          home: appProvider.isLogin == "0" ? LoginPage() : SplashScreen(),
        );
      },
    );
  }
}
