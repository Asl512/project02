import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loadingPage.dart';
import 'navigation.dart';

import 'profil/profil.dart';
import 'profil/authorization.dart';
import 'profil/registration.dart';
import 'excursion/serch.dart';
import 'excursion/city.dart';
import 'test.dart';

void main()
{

  runApp(MaterialApp(
    initialRoute: '/navigation',

    routes:
    {
      '/loading': (context) => const Loading(),
      '/test': (context) => const MyStatefulWidget(),
      '/navigation': (context) => const Navigation(),

      '/serch': (context) => const Serch(),
      '/city': (context) => const City(),

      '/profil': (context) => const Profil(),
      '/authorization': (context) => const Authorization(),
      '/registration': (context) => const Registration(),
    },
  ));
}