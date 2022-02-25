import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'assets/finally.dart';
import 'assets/style.dart';

import 'excursion/city.dart';
import 'profil/profil.dart';

class LocaleNavigation extends StatefulWidget {
  @override
  _LocaleNavigationState createState() => _LocaleNavigationState();
}

class _LocaleNavigationState extends State<LocaleNavigation> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: Navigation(),
      localizationsDelegates: translator.delegates,
      locale: translator.locale,
      supportedLocales: translator.locals(),
    );
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _page = 0;

  List<Widget> _widgetPages = <Widget>[
    City(),
    Container(width: double.infinity, height: double.infinity, color:Grey,
      child: Center(child: Text("myTickets".tr(),style: Montserrat(color:Blue,size: 40,style: SemiBold))),),
    Container(width: double.infinity, height: double.infinity, color:Grey,
      child: Center(child: Text("activity".tr(),style: Montserrat(color:Blue,size: 40,style: SemiBold))),),
    Profil(),
  ];

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            iconMenuExcursion,
            iconMenuTickets,
            iconMenuActivity,
            iconMenuProfil
          ],
          color: Blue,
          buttonBackgroundColor: Blue,
          backgroundColor: Grey.withOpacity(0),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _widgetPages[_page]
    );
  }
}
