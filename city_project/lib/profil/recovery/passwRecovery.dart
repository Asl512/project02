import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:postgres/postgres.dart';
import 'dart:async';
import 'codeRecovery.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';

class passwRecovery extends StatefulWidget
{
  const passwRecovery({Key? key}) : super(key: key);

  @override
  State<passwRecovery> createState() => _passwRecoveryState();
}

class _passwRecoveryState extends State<passwRecovery> {
  List errorEmail = [false,'errorEmail'];
  String email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    return Stack(children: [
        Scaffold(backgroundColor: Grey,

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
                            padding: EdgeInsets.symmetric(horizontal: SizePage.width/10),
                            child: Text("discriptionEnterEmail".tr(), textAlign: TextAlign.center,
                              style: Montserrat(style: SemiBold,size: 13, color:Blue),)
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

                      Validation();
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
    ),

      Positioned(
        child: isLoading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Blue),
            ),
          ),
          color: Colors.white.withOpacity(0.8),
        ) : Container(),
      ),
    ]);
  }

  void Validation() {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
    r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(email == '') {
      setState(() {
        errorEmail = [true,"errorEmptyEmail".tr()];
      });
    }
    else if (emailValid == false) {
      setState(() {
        errorEmail = [true,"errorValidEmail".tr()];
      });
    }
    else{
      CheckEmail();
    }
  }

  Future<Null> CheckEmail() async {
    setState(() {isLoading = true;});

    var connection = PostgreSQLConnection(
        "rc1b-zkri5cth30iw9y0q.mdb.yandexcloud.net", 6432, "tripteam_db",
        username: "TripTeamAdmin2", password: "NCR2I4%Te44A", useSSL: true);
    try {
      await connection.open();
      List emailDB = await connection.query("SELECT * FROM user_tripteam WHERE email = '" + email+"'");
      setState(() {isLoading = false;});
      if(emailDB.isEmpty){
        setState(() {
          errorEmail = [true,"errorDontHaveEmail".tr()];
        });
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (_)=> codeRecovery()));
      }
    }
    catch (e) {
      print('ERROR CONNECT===============');
      print(e.toString());
      setState(() {isLoading = false;});
    }
  }
}

