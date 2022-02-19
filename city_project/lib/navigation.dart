import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/assets/text.dart';

import 'assets/finally.dart';

import 'excursion/city.dart';
import 'profil/profil.dart';


class Navigation extends StatefulWidget
{
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    City(),
    Text(
      'Мои билеты'
    ),
    Text(
      'Активность'
    ),
    Profil(),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      ///ТЕЛО
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      ///МЕНЮ
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: White,
          unselectedItemColor: White.withOpacity(0.5),
          onTap: _onItemTapped,
          backgroundColor: Blue,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: iconMenuExcursionActiv,
              icon: Opacity(child: iconMenuExcursion,opacity:0.5),
              label: textExcursion,
              backgroundColor: Blue,
            ),
            BottomNavigationBarItem(
              activeIcon: iconMenuTickets,
              icon: Opacity(child: iconMenuTickets,opacity:0.5),
              label: textMyTickets,
              backgroundColor: Blue,
            ),
            BottomNavigationBarItem(
              activeIcon: iconMenuActivity,
              icon: Opacity(child: iconMenuActivity,opacity:0.5),
              label: textActivity,
              backgroundColor: Blue,
            ),
            BottomNavigationBarItem(
              activeIcon: iconMMenuProfilActiv,
              icon: Opacity(child: iconMenuProfil,opacity:0.5),
              label: textProfil,
              backgroundColor: Blue,
            ),
          ]),


    );
  }
}