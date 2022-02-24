import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'codeRecovery.dart';

import '../assets/style.dart';
import '../assets/finally.dart';

class passwRecovery extends StatefulWidget
{
  const passwRecovery({Key? key}) : super(key: key);

  @override
  State<passwRecovery> createState() => _passwRecoveryState();
}

class _passwRecoveryState extends State<passwRecovery> {
  bool passwordVisible = true;
  bool isChecked = false;
  List errorPassword = [false,'errorPassword'];
  List errorEmail = [false,'errorEmail'];
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(50),
            child: AppBar(backgroundColor:Grey, elevation: 0.0,
                leading: Container(
                  width: 70,
                  decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                  child: Transform.rotate(angle: 45*3.14/90,
                    child: IconButton(icon: iconArrowBottomWhite,
                      onPressed: (){
                        Navigator.pop(context);
                      },),
                  ),
                )
            )
        ),

        body:ListView(shrinkWrap: true,
          children: [
            Container(
              height: SizePage.height/5-70,
              child: Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: SizePage.width/15),
                  child:Text("pswRec".tr(), style: Montserrat(style:Bold,color:Blue, size: 30))
              ),
            ),
            Container(
                height: SizePage.height/2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///EMAIL
                        Container(height: 112,
                            child: Column(children:[
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("email".tr(), style: Montserrat(color:Blue,style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50,500), // ТЕНЬ
                                TextField(style: Montserrat(color:Blue,style: SemiBold),
                                    onChanged: (String value)
                                    {setState(() {
                                      email = value;
                                      errorEmail[0] = false;
                                    });},
                                    decoration: InputDecoration(
                                      //ИКОНКА
                                        prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Color(0xFF546eff),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconEmail
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: errorEmail[0] == true ? errorEmail[1] : null,
                                        errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                        //СТИЛЬ
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                            borderSide: BorderSide(width: 0, style: errorEmail[0] == true ? BorderStyle.solid : BorderStyle.none)
                                        ),
                                        fillColor: White,
                                        isDense: true,
                                        filled: true
                                    )
                                )
                              ])
                            ])
                        ),
                        ///ТЕКСТ
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: SizePage.width/5),
                          child: Text("discriptionEnterEmail".tr(), style: Montserrat(style: SemiBold,size: 13, color:Blue),)
                        ),

                      ]),
                )
            ),


            Container(
                height: SizePage.height/3-60,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///КНОПКА ДАЛЕЕ
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> codeRecovery()));
                    },
                        child: Container(width: SizePage.width-SizePage.width/15*2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(Radius.circular(500))),
                            child: Center(child: Text("next".tr(), style: Montserrat(style: SemiBold,size: 19)),)
                        )
                    ),

                  ],
                )
            ),
          ],
        )
    );
  }

  void Validation()
  {
    setState(() {
      bool check = true;
      if(email == '')
      {
        check = false;
        errorEmail[0] = true;
        errorEmail[1] = "errorEmptyEmail".tr();
      }

      if(password == '')
      {
        check = false;
        errorPassword[0] = true;
        errorPassword[1] = "errorEmptyPassword".tr();
      }

      ///проверка в бд
      if(check == true)
      {
      }
    });
  }

}

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> Conditions = [
      TextDialogWindows("termsOneTitle".tr(),"termsOneText".tr()),
      TextDialogWindows("termsTwoTitle".tr(),"termsTwoText".tr())
    ];

    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top:25,left: 30,right: 30),
              decoration: BoxDecoration(color: Blue,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: Conditions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Conditions[index];
                },
              ),
            ),

            Container(width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/2.3,vertical: 10),
              height: 4,
              decoration: BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),
            )
          ],
        );
      },
    );
  }
}