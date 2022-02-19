import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';

class Profil extends StatefulWidget
{
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  @override
  Widget build(BuildContext context)
  {

    ///ПРОВЕРКА НА АВТОРИЗАЦИЮ
    return NotAutorization();
  }
}


class NotAutorization extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

        body:Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iProfil, width: SizePage.width/1.3, height: SizePage.width/1.3, fit:BoxFit.fill),
              Container( padding: EdgeInsets.symmetric(horizontal: SizePage.width/6),
                child:Text(textNotAutorization, style: Montserrat(style: SemiBold,size: 16,color:Blue)),
              ),
              Container(margin: EdgeInsets.only(top: 20),
                  child: TextButton(onPressed: (){
                    showModalBottomSheet<void>(
                        backgroundColor:White.withOpacity(0),
                        context: context,
                        builder: (BuildContext context) {
                          return ShowDialog();
                        });
                  },
                      child: Container(width: SizePage.width-SizePage.width/5,
                          height: 50,
                          decoration: BoxDecoration(color: Blue,
                              borderRadius: BorderRadius.all(Radius.circular(500))),
                          child: Center(child: Text(textAutorization, style: Montserrat(style: SemiBold,size: 19)),)))
              ),
            ])
    );
  }
}

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        Container(
          height: 200,
          width: double.infinity,
          padding: EdgeInsets.only(top:25),
          decoration: BoxDecoration(color: Blue,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))),
          child: Column(children: [
            Text(textAutorization,style: Montserrat(color:White,style: SemiBold,size: 15)),
            Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
              margin: EdgeInsets.only(top: 10,bottom: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(alignment: Alignment.center,
                      children: [
                        Container(width: 45,height: 45, decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                        IconButton(onPressed:(){}, icon: iconVK, iconSize: 50,),
                      ]
                  ),

                  Stack(alignment: Alignment.center,
                      children: [
                        Container(width: 45,height: 45,decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                        IconButton(onPressed:(){}, icon: iconFacebook, iconSize: 50,),
                      ]
                  ),

                  Stack(alignment: Alignment.center,
                      children: [
                        Container(width: 45,height: 45,decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                        IconButton(onPressed:(){}, icon: iconGoogle, iconSize: 50,),
                      ]
                  )
                ],
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/authorization');
                },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: White,
                            borderRadius: BorderRadius.all(Radius.circular(500))),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(textWelcome, style: Montserrat(style: SemiBold,size: 18,color:Blue))
                        )
                    )
                ),

                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/registration');
                },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: White,
                            borderRadius: BorderRadius.all(Radius.circular(500))),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(textRegistration, style: Montserrat(style: SemiBold,size: 18,color:Blue))
                        )
                    )
                ),
              ],
            )
          ]),
        ),

        Container(
            alignment: Alignment.topCenter,
            height: 200,
            padding: EdgeInsets.only(top: 10),
            child: Container(width: 50,
              height: 4,
              decoration: BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),
            ),
        )
    ]);
  }
}