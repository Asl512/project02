import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';

class RecoveryTwo extends StatefulWidget
{
  const RecoveryTwo({Key? key}) : super(key: key);

  @override
  State<RecoveryTwo> createState() => _RecoveryTwoState();
}

class _RecoveryTwoState extends State<RecoveryTwo> {
List errorCode = [false,'errorCode'];

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
                        height: MediaQuery.of(context).size.height/3+70,
                        child:Text(textRecoveryPassword, style: Montserrat(style:SemiBold,color:Blue, size: 28))
                    )),
                ///EMAIL
                Flexible(flex: 2,
                    child: Container(width: double.infinity,
                    height: MediaQuery.of(context).size.height/3-20,
                    child: Column(children:[

                      Container(width: double.infinity,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text(textInstructionRecoveryTwo, style: Montserrat(color:Blue)),
                      ),

                      Stack(children: [
                        Shadow(50,500), // ТЕНЬ
                        TextField(style: Montserrat(color:Blue),
                            decoration: InputDecoration(
                              //ИКОНКА
                                prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15),
                                    child: iconEmail
                                ),

                                //ВЫВОД ОШИБКИ
                                errorText: errorCode[0] == true ? errorCode[1] : null,
                                errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                //СТИЛЬ
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                    borderSide: BorderSide(width: 0, style: errorCode[0] == true ? BorderStyle.solid : BorderStyle.none)
                                ),
                                fillColor: White,
                                isDense: true,
                                filled: true
                            )
                        )
                      ])
                    ])
                    )
                ),

                Flexible(flex: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height/3-50,
                      child: Column(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ///КНОПКА ДАЛЕЕ
                          Container(padding: EdgeInsets.only(left: 106,right: 106,bottom: 100),
                              child:TextButton(
                                style: TextButton.styleFrom(minimumSize: Size.fromHeight(60),
                                    primary: Green,
                                    backgroundColor: GreenReady
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushNamed(context, '/recoveryThree');
                                    errorCode[0] = !errorCode[0];
                                  });
                                },
                                child: Text(textNext, style: Montserrat(style:Bold)),
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