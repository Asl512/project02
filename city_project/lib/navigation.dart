import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:lan_code/service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'assets/finally.dart';
import 'assets/style.dart';

import 'excursion/city.dart';
import 'profil/profil.dart';

class Navigation extends StatefulWidget {
  const Navigation({this.index = 0,Key? key}) : super(key: key);
  final int? index;
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int page = widget.index ?? 0;

  String idCity = '';
  DocumentSnapshot? data;
  bool isLoading = false;
  List types = [];
  DocumentSnapshot? userData;

  void getData(UserMeth? userMeth) async {
    if(this.idCity == '') {
      setState(()=>isLoading = true);
      ///Получаем данные города
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(()=>this.idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9');
      this.data = await FirebaseFirestore.instance.collection('city').doc(idCity).get();
      await FirebaseFirestore.instance.collection('typeExcursion').get().then((snapshot) => {
        setState(()=>this.types = snapshot.docs)
      });

      ///Получаем данные о юзере
      setState(()=>isLoading = false);
    }
    if(userMeth != null)
      {
        if(userData == null) this.userData  = await FirebaseFirestore.instance.collection('user').doc(userMeth.id?.trim()).get();
      }
  }

  @override
  Widget build(BuildContext context) {
    final UserMeth? user = Provider.of<UserMeth?>(context);
    getData(user);

    List<Widget> widgetPages = <Widget>[
      City(this.idCity,this.data,this.types),
      Container(width: double.infinity, height: double.infinity, color:Grey,
        child: Center(child: Text("Мои билеты",style: Montserrat(color:Blue,size: 40,style: SemiBold))),),
      Container(width: double.infinity, height: double.infinity, color:Grey,
        child: Center(child: Text("Активность",style: Montserrat(color:Blue,size: 40,style: SemiBold))),),
      Profil(),
    ];

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
              title: Text("Экскурсии",style: Montserrat(color: White,size: 13),),
            ),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: iconMenuTickets,
                activeIcon: iconMenuTickets,
                title: Text("Мои билеты",style: Montserrat(color: White,size: 13),)),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: iconMenuActivity,
                activeIcon: iconMenuActivity,
                title: Text("Активность",style: Montserrat(color: White,size: 13),)),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: iconMenuProfil,
                activeIcon: iconMenuProfil,
                title: Text("Профиль",style: Montserrat(color: White,size: 13),)),
          ],
        ),

        body: this.isLoading?Center(child: CircularProgressIndicator(color: Blue)):widgetPages[page]
    );
  }
}
