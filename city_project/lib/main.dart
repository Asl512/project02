import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loadingPage.dart';
import 'navigation.dart';

import 'profil/profil.dart';
import 'profil/authorization.dart';
import 'profil/registration.dart';
import 'profil/settings.dart';
import 'excursion/search.dart';
import 'excursion/city.dart';
import 'test.dart';
import 'profil/recovery/passwRecovery.dart';
import 'IntroPage.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int checkLook = prefs.getInt('look') ?? 0;

  runApp(StreamProvider<UserMeth?>.value(
    value: AuthService().currentUser,
    initialData: null,
    child: MaterialApp(

      initialRoute: checkLook!=0?'/navigation':'/introPage',

      routes:
      {
        '/loading': (context) => const Loading(),
        //'/test': (context) =>  MyApp(),
        '/navigation': (context) =>  Navigation(),
        '/introPage': (context) =>  IntroPage(),

        '/setting': (context) => const Local(),

        '/search': (context) => const Serch(),

        '/authorization': (context) => const Authorization(),
        '/pass': (context) => const passwRecovery(),
        '/registration': (context) => const Registration(),
      },
    ),
  ));
}