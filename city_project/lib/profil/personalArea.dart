import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../assets/style.dart';
import '../assets/finally.dart';

import 'settings.dart';

class personalArea extends StatelessWidget {
  dynamic user;
  personalArea(this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50),
          child: AppBar(backgroundColor:Grey, elevation: 0.0,
            actions: [
              Container(
                child: IconButton(icon: iconSetting,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Local()));
                  },),
              )
            ],
          )
      ),
      body: ListView(shrinkWrap: true,
          children: [
          Container(
            width: double.infinity,
            height: 62,
            margin: const EdgeInsets.all(22),
            child: Row(
              children: [
                PhotoCircle(),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Text(user!['name'].toString(), style: Montserrat(style: Bold, color: Blue, size: 24), textAlign: TextAlign.left),
                      Text('Стаус', style: Montserrat(color: Blue, size: 14), textAlign: TextAlign.left),
                ]
              ),
            ],
          )
        ),
            Container(
                width: double.infinity,
                height: 62,
                margin: const EdgeInsets.fromLTRB(22, 55, 22, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Blue,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [iconMenuProfil,
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Text('Управление профилем', style: Montserrat(style: Bold, color: Blue, size: 14), textAlign: TextAlign.left),
                          Text('Доступные проверки и расширения', style: Montserrat(color: Blue, size: 11), textAlign: TextAlign.left)
                        ]
                    ),
                  ],
                ),
            ),
            Container(
              width: double.infinity,
              height: 62,
              margin: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Blue,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  iconMenuProfil,
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('Статистика', style: Montserrat(style: Bold, color: Blue, size: 14), textAlign: TextAlign.left),
                        Text('Описание статистики', style: Montserrat(color: Blue, size: 11), textAlign: TextAlign.left)
                      ]
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 62,
              margin: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Blue,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  iconMenuProfil,
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('Мои экскурсии', style: Montserrat(style: Bold, color: Blue, size: 14), textAlign: TextAlign.left),
                        Text('Экскурсии в которых вы являетесь гидом', style: Montserrat(color: Blue, size: 11), textAlign: TextAlign.left)
                      ]
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 62,
              margin: const EdgeInsets.fromLTRB(22, 170, 22, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Blue,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  iconMenuProfil,
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('О приложении', style: Montserrat(style: SemiBold, color: Blue, size: 14), textAlign: TextAlign.left),
                      ]
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 62,
              margin: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Row(
                children: [
                  iconMenuProfil,
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('Служба поддержки', style: Montserrat(style: SemiBold, color: Blue, size: 14), textAlign: TextAlign.left),
                      ],
                  ),
                ],
              ),
            ),
            TextButton(onPressed: () {
              AuthService().loyaut();
            },
                child: Container(
                    width: 290,
                    height: 50,
                    decoration: BoxDecoration(color: Red,
                        borderRadius: BorderRadius.all(
                            Radius.circular(500))),
                    child: Center(child: Text("Выйти из аккаунта".tr(),
                        style: Montserrat(style: Bold, size: 18)),)
                )
            ),
      ],
      )
    );
  }
}

class PhotoCircle extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      width: 62,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
    );
  }
}

/*class NameStatus extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text(

    );
  }
}*/


