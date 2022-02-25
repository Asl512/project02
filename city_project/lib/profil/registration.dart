import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


import '../assets/style.dart';
import '../assets/finally.dart';
import 'authorization.dart';

class Registration extends StatefulWidget
{
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool passwordVisible = true;
  bool isChecked = false;
  List errorName = [false, 'errorName'];
  List errorPassword = [false, 'errorPassword'];
  List errorEmail = [false, 'errorEmail'];
  String name = '';
  String email = '';
  String password = '';
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size SizePage = MediaQuery
        .of(context)
        .size;
    return Scaffold(backgroundColor: Grey,

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(50),
            child: AppBar(backgroundColor: Grey, elevation: 0.0,
                leading: Container(
                  width: 70,
                  decoration: BoxDecoration(color: Blue,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40))),
                  child: Transform.rotate(angle: 45 * 3.14 / 90,
                    child: IconButton(icon: iconArrowBottomWhite,
                      onPressed: () {
                        Navigator.pop(context);
                      },),
                  ),
                )
            )
        ),

        body: ListView(shrinkWrap: true,
          children: [
            Container(
              height: SizePage.height / 5 - 70,
              child: Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: SizePage.width / 15),
                  child: Text("registration".tr(),
                      style: Montserrat(style: Bold, color: Blue, size: 30))
              ),
            ),
            Container(
                height: SizePage.height / 2 ,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizePage.width / 15),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        ///NAME
                        Container(
                            child: Column(children: [
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("nameSurname".tr(),
                                    style: Montserrat(
                                        color: Blue, style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50, 500), // ТЕНЬ
                                TextField(style: Montserrat(
                                    color: Blue, style: SemiBold),
                                    onChanged: (String value) {
                                      setState(() {
                                        name = value;
                                        errorName[0] = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      //ИКОНКА
                                        prefixIcon: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Color(0xFFffaf5a),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconMenuProfil
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: errorName[0] == true
                                            ? errorName[1]
                                            : null,
                                        errorStyle: Montserrat(style: Medium,
                                            color: Red,
                                            size: 15),

                                        //СТИЛЬ
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                500),
                                            borderSide: BorderSide(width: 0,
                                                style: errorName[0] == true
                                                    ? BorderStyle.solid
                                                    : BorderStyle.none)
                                        ),
                                        fillColor: White,
                                        isDense: true,
                                        filled: true
                                    )
                                )
                              ])
                            ])
                        ),

                        ///EMAIL
                        Container(
                            child: Column(children: [
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("email".tr(), style: Montserrat(
                                    color: Blue, style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50, 500), // ТЕНЬ
                                TextField(style: Montserrat(
                                    color: Blue, style: SemiBold),
                                    onChanged: (String value) {
                                      setState(() {
                                        email = value;
                                        errorEmail[0] = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      //ИКОНКА
                                        prefixIcon: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Color(0xFF546eff),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconEmail
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: errorEmail[0] == true
                                            ? errorEmail[1]
                                            : null,
                                        errorStyle: Montserrat(style: Medium,
                                            color: Red,
                                            size: 15),

                                        //СТИЛЬ
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                500),
                                            borderSide: BorderSide(width: 0,
                                                style: errorEmail[0] == true
                                                    ? BorderStyle.solid
                                                    : BorderStyle.none)
                                        ),
                                        fillColor: White,
                                        isDense: true,
                                        filled: true
                                    )
                                )
                              ])
                            ])
                        ),

                        Column(
                          children: [
                            ///PASSWORD
                            Container(
                                child: Column(children: [
                                  Container(width: double.infinity,
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                    child: Text("password".tr(), style: Montserrat(
                                        color: Blue, style: SemiBold)),
                                  ),

                                  Stack(children: [
                                    Shadow(50, 500), // ТЕНЬ

                                    TextField(
                                        controller: controller,
                                        style: Montserrat(
                                            color: Blue, style: SemiBold),
                                        obscureText: passwordVisible,
                                        onChanged: (String value) {
                                          setState(() {
                                            password = value;
                                            errorPassword[0] = false;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          //ИКОНКА
                                            prefixIcon: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: Color(0xFF00f069),
                                                ),
                                                width: 40,
                                                padding: EdgeInsets.all(6),
                                                child: iconPassword
                                            ),

                                            //СКРЫТЬ/ПОКАЗАТЬ
                                            suffixIcon: Container(
                                                margin: EdgeInsets.only(right: 10),
                                                child: IconButton(
                                                  icon: passwordVisible == true
                                                      ? iconShow
                                                      : iconHide,
                                                  onPressed: () {
                                                    setState(() {
                                                      passwordVisible =
                                                      !passwordVisible;
                                                    });
                                                  },
                                                )
                                            ),

                                            //ВЫВОД ОШИБКИ
                                            errorText: errorPassword[0] == true
                                                ? errorPassword[1]
                                                : null,
                                            errorStyle: Montserrat(style: Medium,
                                                color: Red,
                                                size: 15),

                                            //СТИЛЬ
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    500),
                                                borderSide: BorderSide(width: 0,
                                                    style: errorPassword[0] == true
                                                        ? BorderStyle.solid
                                                        : BorderStyle.none)
                                            ),
                                            fillColor: White,
                                            isDense: true,
                                            filled: true
                                        )
                                    ),
                                  ])
                                ])
                            ),
                            new SizedBox(
                              height: 10,
                            ),
                            new FlutterPwValidator(
                              controller: controller,
                              minLength: 6,
                              numericCharCount: 1,
                              width: SizePage.width,
                              height: SizePage.height/15,
                              onSuccess: (){},
                            )
                          ],
                        )
                      ]),
                )
            ),

            Container(
                height: SizePage.height / 3 - 60,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    ///КНОПКА ЗАРЕГЕСТРИРОВАТЬСЯ
                    TextButton(onPressed: () {
                      Validation();
                      Registration();
                    },
                        child: Container(
                            width: SizePage.width - SizePage.width / 15 * 2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(500))),
                            child: Center(child: Text("registration2".tr(),
                                style: Montserrat(style: SemiBold, size: 19)),)
                        )
                    ),

                    ///ТЕКСТ
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizePage.width / 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "terms".tr(),
                              style: Montserrat(
                                  style: SemiBold, size: 13, color: Blue),
                            ),
                            TextSpan(
                              text: "more".tr(),
                              style: Montserrat(
                                  style: SemiBold, size: 13, color: Red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showModalBottomSheet(
                                      backgroundColor: White.withOpacity(0),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowDialog();
                                      });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }

  void Validation() {
    setState(() {
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
      r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
      if (emailValid == false) {
        errorEmail[0] = true;
        errorEmail[1] = "errorEmptyEmail".tr();
      }
      if (name == '') {
        errorName[0] = true;
        errorName[1] = "errorEmptyName".tr();
      }
    });
  }

  void Registration() async
  {
    var connection = PostgreSQLConnection(
        "rc1b-zkri5cth30iw9y0q.mdb.yandexcloud.net", 6432, "tripteam_db",
        username: "TripTeamAdmin2", password: "NCR2I4%Te44A", useSSL: true);
    try {
      await connection.open();
      await connection.query("INSERT INTO user_tripteam "
          "(name, email, password) VALUES ('" + name + "', '" + email + "', '" +
          password + "');");
    }
    catch (e) {
      print('ERROR CONNECT===============');
      print(e.toString());
      throw Exception(e);
    }
  }
}