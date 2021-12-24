import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';

class RecoveryThree extends StatefulWidget
{
  const RecoveryThree({Key? key}) : super(key: key);

  @override
  State<RecoveryThree> createState() => _RecoveryThreeState();
}

class _RecoveryThreeState extends State<RecoveryThree> {
  bool passwordVisible = false;
  List errorNewPassword = [false,'errorNewPassword'];
  bool passwordVisible2 = false;
  List errorPasswordRepeat = [false,'errorPasswordRepeat'];

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(backgroundColor: LigthGreen,
        body:Stack(children: [
            ///ТРЕУГОЛЬНИКИ
            ListView(children:[
              Stack(children:[
                ClipPath(clipper: Triangle(1),
                    child: Container(decoration: BoxDecoration(color: GreenReady.withOpacity(0.5)),height: 500,width: 500,)
                ),
                ClipPath(clipper: Triangle(2),
                    child: Container(decoration: BoxDecoration(color: LigthGreen,),height: 500,width: 500,)
                ),
              ])
            ]),

          ListView(padding: EdgeInsets.symmetric(horizontal: 14),
              shrinkWrap: true,
              children: [
                ///ШАПКА
                Flexible(flex: 1,
                    child: Container(alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height/3+40,
                        child:Text(textRecoveryPassword, style: Montserrat(style:SemiBold,color:Blue, size: 28))
                    )),

                Flexible(flex: 2,
                    child: Container(width: double.infinity,
                    height: MediaQuery.of(context).size.height/3+10,
                    child: Column(children:[

                      ///NEW PASSWORD
                      Container(child: Column(children: [
                        Container(width: double.infinity,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Text(textNewPassword, style: Montserrat(color:Blue)),
                        ),

                        Stack(children:[
                          Shadow(50,500),// ТЕНЬ

                          TextField(style: Montserrat(color:Blue),
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                //ИКОНКА
                                  prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15),
                                      child: iconPassword
                                  ),

                                  //СКРЫТЬ/ПОКАЗАТЬ
                                  suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        icon: passwordVisible == true ? iconShow : iconHide,
                                        onPressed: ()
                                        {
                                          setState(()
                                          {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      )
                                  ),

                                  //ВЫВОД ОШИБКИ
                                  errorText: errorNewPassword[0] == true ? errorNewPassword[1] : null,
                                  errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                  //СТИЛЬ
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                      borderSide: BorderSide(width: 0, style: errorNewPassword[0] == true ? BorderStyle.solid : BorderStyle.none)
                                  ),
                                  fillColor: White,
                                  isDense: true,
                                  filled: true
                              )
                          )
                        ])
                      ],),
                      ),

                      ///RETURN PASSWORD
                      Container(margin: EdgeInsets.only(top: 30),
                        child: Column(children: [
                        Container(width: double.infinity,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Text(textRepeatPassword, style: Montserrat(color:Blue)),
                        ),

                        Stack(children:[
                          Shadow(50,500),// ТЕНЬ

                          TextField(style: Montserrat(color:Blue),
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                //ИКОНКА
                                  prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15),
                                      child: iconPassword
                                  ),

                                  //СКРЫТЬ/ПОКАЗАТЬ
                                  suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        icon: passwordVisible2 == true ? iconShow : iconHide,
                                        onPressed: ()
                                        {
                                          setState(()
                                          {
                                            passwordVisible2 = !passwordVisible2;
                                          });
                                        },
                                      )
                                  ),

                                  //ВЫВОД ОШИБКИ
                                  errorText: errorPasswordRepeat[0] == true ? errorPasswordRepeat[1] : null,
                                  errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                  //СТИЛЬ
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                      borderSide: BorderSide(width: 0, style: errorPasswordRepeat[0] == true ? BorderStyle.solid : BorderStyle.none)
                                  ),
                                  fillColor: White,
                                  isDense: true,
                                  filled: true
                              )
                          )
                        ])
                      ],),
                      )
                    ])
                    )
                ),

                Flexible(flex: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height/3-50,
                      child: Column(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ///КНОПКА ГОТОВО
                          Container(padding: EdgeInsets.only(left: 106,right: 106,bottom: 100),
                              child:TextButton(
                                style: TextButton.styleFrom(minimumSize: Size.fromHeight(60),
                                    primary: Green,
                                    backgroundColor: GreenReady
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushNamedAndRemoveUntil(context, '/authorization', (route) => false);
                                  });
                                },
                                child: Text(textReady, style: Montserrat(style:Bold)),
                              )
                          ),
                        ],
                      ),
                    )
                ),
              ]
          )


        ])
    );
  }
}