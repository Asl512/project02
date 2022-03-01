import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import 'serch.dart';
import 'excursionClass.dart';


class Excursion extends StatefulWidget
{
  const Excursion(this.idExcursion,{Key? key}) : super(key: key);
  final String? idExcursion;

  @override
  State<Excursion> createState() => _ExcursionState();
}

class _ExcursionState extends State<Excursion> {

  DocumentSnapshot? data;
  bool isLoading = false;

  void getData() async {
    if(this.data == null) {
      setState(() {isLoading = true;});
        this.data = await FirebaseFirestore.instance.collection('city').doc(widget.idExcursion).get();
      setState(() {isLoading = false;});
      }
  }

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    getData();

    if (this.isLoading){
      return Container(color: Grey,
      child: Center(
        child: Column(children: [
          WaitDialog(iLoading,"textLoading".tr()),
          Container(padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(color: Blue)
          )
        ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ));
    }
    else{
      return Scaffold(backgroundColor: Grey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizePage.height / 5),

            ///ШАПКА
            child: AppBar(flexibleSpace: Stack(alignment: AlignmentDirectional.topStart,
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Stack(children: [
                      Image.network('https://cdnmyslo.ru/CityImage/08/0c/080c85a8-50e3-4c45-8373-b0ea266544b4_1.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Placholder(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(excursionDef,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height
                          );
                        },
                      ),
                      Container(width: double.infinity, height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5))
                      ),
                      Container(alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text("qwert yuiopasd fghjklz xcvbnm nbvcx zasdg hjklp oiuyte".toUpperCase(),
                                  style: Montserrat(color: White, size: 25, style: Bold))),
                            ],
                          )
                      )
                    ]),

                    Row(mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          Container(padding: EdgeInsets.symmetric(horizontal: 15),
                              height: 50, alignment: Alignment.center,
                              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                                  color: Colors.black.withOpacity(0.5)),
                              child: Stack(children: [
                                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(500)),
                                    child: getPhotoAuthor()
                                ),
                                GuideCheck(true)
                              ])),
                          Container(color: Colors.black.withOpacity(0.5),height: 50,
                            padding: EdgeInsets.only(right: 15),
                            alignment: Alignment.center,
                            child: Text('Иван Иванов',style: Montserrat(size: 15,style: SemiBold))
                          )
                        ])
                  ],
                ),
                Container(
                    height: 70,width: 50,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                    child: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: White,),
                        onPressed: (){
                          Navigator.pop(context);
                        })
                ),
            ],),

              centerTitle: false,
              titleSpacing: 0.0,
            )
        ),

        body: Text('d'),
      );
    }
  }
  Widget GuideCheck(bool check){
    if(check)
    {
      return Container(width: 40,height: 40,
          alignment: Alignment.bottomRight,
          child: Container(width: 15,height: 15,
              child: iconConfirmation)
      );
    }
    else
    {
      return Container();
    }
  }

  Widget getPhotoAuthor(){
    if(true){
      return Image.asset(avatarDef,
        fit: BoxFit.cover,
        width: 40, height: 40,
      );
    }else{
      return Image.network('https://cdnmyslo.ru/CityImage/08/0c/080c85a8-50e3-4c45-8373-b0ea266544b4_1.jpg',
        fit: BoxFit.cover,
        width: 40, height: 40,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(avatarDef,
            fit: BoxFit.cover,
            width: 40, height: 40,
          );
        },
      );
    }
  }
}