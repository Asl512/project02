import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'doublePsw.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';

class codeRecovery extends StatefulWidget
{
  const codeRecovery({Key? key}) : super(key: key);

  @override
  State<codeRecovery> createState() => _codeRecoveryState();
}

class _codeRecoveryState extends State<codeRecovery> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

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
                  child:Text("codeRec".tr(), style: Montserrat(style:Bold,color:Blue, size: 30))
              ),
            ),
            Container(
                height: SizePage.height/2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///KEY
                        Container(child: Column(children:[

                          Form(
                              key: formKey,
                              child: PinCodeTextField(
                                appContext: context,
                                length: 6,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    activeFillColor: White,
                                    activeColor: Blue,
                                    selectedColor: Blue,
                                    selectedFillColor: White,
                                    inactiveColor: Blue,
                                    inactiveFillColor: White,
                                    errorBorderColor: Red
                                ),
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                errorAnimationController: errorController,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,
                                onCompleted: (v) {CheckCode();},
                                onChanged: (value) {
                                  setState(() {currentText = value;});
                                },
                              )),
                            ])
                        ),

                        ///ВЫВОД ОШИБКИ
                        Container(child: Text(hasError ? "errorEnterCode".tr() : "", style: Montserrat(size: 15, color: Red)),
                          margin: EdgeInsets.only(bottom: 20),
                        ),


                        ///ТЕКСТ
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: SizePage.width/10),
                            child: Text("discriptionEnterCode".tr(), textAlign: TextAlign.center,
                              style: Montserrat(style: SemiBold,size: 13, color:Blue),)
                        ),

                      ]),
                )
            ),

            Container(
                height: SizePage.height/3-60,
                child: Column(
                  children: [

                    ///КНОПКА ДАЛЕЕ
                    TextButton(onPressed: (){CheckCode();},
                        child: Container(width: SizePage.width-SizePage.width/15*2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(Radius.circular(500))),
                            child: Center(child: Text("next".tr(), style: Montserrat(style: SemiBold,size: 19)),)
                        )
                    ),


                    ButtonRetry()
                  ],
                )
            ),
          ],
        )
    );
  }

  void CheckCode(){
    formKey.currentState!.validate();
    if (currentText.length != 6 || currentText != "123456") {
      errorController!.add(ErrorAnimationType.shake);
      setState(() => hasError = true);
    } else {
      setState(() {
          hasError = false;
          Navigator.push(context, MaterialPageRoute(builder: (_)=> doublePsw()));
        },
      );
    }
  }
}

class ButtonRetry extends StatefulWidget
{
  const ButtonRetry({Key? key}) : super(key: key);

  @override
  State<ButtonRetry> createState() => _ButtonRetryState();
}

class _ButtonRetryState extends State<ButtonRetry> {
  int count = 0;

  void countM()async{
    await Future<void>.delayed(const Duration(seconds: 1));
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if(count <= 0)
      {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("dontReceiveCode".tr(), style: Montserrat(color:Blue, size: 16)),
            TextButton(
                onPressed: () {
                  setState(() {
                    count = 15;
                  });
                },
                child: Text("repeat".tr(), style: Montserrat(color:Red,style: SemiBold, size: 16))
            )
          ],
        );
      }
    else{
      countM();
      return Container(margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text("sentCode".tr(), style: Montserrat(color:Blue, size: 16)),
          Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
              alignment: Alignment.center,
              child: Text('resendWillBe'.tr().replaceFirst("-", count.toString()),
                style: Montserrat(color:Red, size: 13),
                textAlign: TextAlign.center,
              )
          )
        ],
      ));
    }
  }
}