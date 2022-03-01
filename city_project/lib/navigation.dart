import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';


import 'assets/finally.dart';
import 'assets/style.dart';

import 'excursion/city.dart';
import 'profil/profil.dart';

class LocaleNavigation extends StatefulWidget {
  const LocaleNavigation({this.index = 0,Key? key}) : super(key: key);
  final int? index;
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
      home: Navigation(index: widget.index),
      localizationsDelegates: translator.delegates,
      locale: translator.locale,
      supportedLocales: translator.locals(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({this.index = 0,Key? key}) : super(key: key);
  final int? index;
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int page = widget.index ?? 0;

  List<Widget> _widgetPages = <Widget>[
    City(),
    Container(width: double.infinity, height: double.infinity, color:Grey,
      child: Center(child: Text("myTickets".tr(),style: Montserrat(color:Blue,size: 40,style: SemiBold))),),
    Container(width: double.infinity, height: double.infinity, color:Grey,
      child: Center(child: Text("activity".tr(),style: Montserrat(color:Blue,size: 40,style: SemiBold))),),
    Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        ///floatingActionButton: FloatingActionButton(
          ///onPressed: () {},
          ///child: Icon(Icons.add),
          ///backgroundColor: Blue,
        ///),
        ///floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          backgroundColor: Blue,
          hasNotch: true,
          ///fabLocation: BubbleBottomBarFabLocation.end,
          opacity: .2,
          currentIndex: page,
          onTap: (index) {setState(()=>page = index!);},
          elevation: 8,
          tilesPadding: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: iconMenuExcursion,
              activeIcon: iconMenuExcursion,
              title: Text("excursion".tr(),style: Montserrat(color: White,size: 13),),
            ),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: iconMenuTickets,
                activeIcon: iconMenuTickets,
                title: Text("myTickets".tr(),style: Montserrat(color: White,size: 13),)),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: iconMenuActivity,
                activeIcon: iconMenuActivity,
                title: Text("activity".tr(),style: Montserrat(color: White,size: 13),)),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: iconMenuProfil,
                activeIcon: iconMenuProfil,
                title: Text("profil".tr(),style: Montserrat(color: White,size: 13),)),
          ],
        ),

        body: _widgetPages[page]
    );
  }
}
