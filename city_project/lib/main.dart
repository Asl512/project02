import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loadingPage.dart';
import 'navigation.dart';

import 'profil/profil.dart';
import 'profil/authorization.dart';
import 'profil/registration.dart';
import 'profil/settings.dart';
import 'excursion/serch.dart';
import 'excursion/city.dart';
import 'test.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ru', 'en'],
    assetsDirectory: 'assets/locales/',
  );

  runApp(LocalizedApp(child: MaterialApp(
    initialRoute: '/navigation',

    routes:
    {
      '/loading': (context) => const Loading(),
      //'/test': (context) =>  MyApp(),
      '/navigation': (context) =>  LocaleNavigation(),

      '/setting': (context) => const Local(),

      '/serch': (context) => const Serch(),
      '/city': (context) => City(),

      '/profil': (context) => const Profil(),
      '/authorization': (context) => const Authorization(),
      '/registration': (context) => const Registration(),
    },
  )));
}