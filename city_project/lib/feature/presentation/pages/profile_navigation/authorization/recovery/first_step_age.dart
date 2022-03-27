import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lan_code/feature/presentation/libary/customSnackBar.dart';
import 'package:lan_code/feature/presentation/libary/topSnackBart.dart';
import 'package:lan_code/feature/presentation/widgets/button_widget.dart';

import '../../../../../../common/colors.dart';
import '../../../../../../common/icons.dart';
import '../../../../../../common/textStyle.dart';
import '../../../../widgets/text_field_style.dart';
import 'second_step_page.dart';

class FirstStepPage extends StatefulWidget
{
  const FirstStepPage({Key? key}) : super(key: key);

  @override
  State<FirstStepPage> createState() => _FirstStepPageState();
}

class _FirstStepPageState extends State<FirstStepPage> {
  bool errorEmail = false;
  String email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size sizePage = MediaQuery.of(context).size;
    return Stack(
        children: [
          Scaffold(
              backgroundColor: Grey,

            appBar: AppBar(
              backgroundColor:Grey,
              elevation: 0.0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,size: 20,color: Blue),
                  onPressed: ()=>Navigator.pop(context)
              ),
              title: Text(
                  "Восстановление пароля 1/3",
                  style: Montserrat(size: 25,style: Bold)),
            ),

              body:ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                      height: sizePage.height/20*10,
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        padding: EdgeInsets.symmetric(horizontal: sizePage.width/15),
                        child: Column(
                            children:[

                              ///EMAIL
                              Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:[
                                    const TitleTextFormField(text: "Почта:"),
                                    TextFieldWithShadow(
                                      TextField(
                                          style: Montserrat(color: Blue, size: 15),
                                          onChanged: (String value) {
                                            setState(() {
                                              email = value;
                                              errorEmail = false;
                                            });},
                                          decoration: TextFieldDecoration(
                                              hintText: "Введите вашу почту",
                                              prefixIcon: PrefixIconTextField(color: const Color(0xFF546eff),icon: iconEmail)
                                          ).inputDecoration
                                      ),
                                      error: [errorEmail],
                                    )
                                  ]
                              ),

                              ///ТЕКСТ
                              Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  padding: EdgeInsets.symmetric(horizontal: sizePage.width/10),
                                  child: Text("Введите почту с которой вы регистрировались в приложении", textAlign: TextAlign.center,
                                    style: Montserrat(style: SemiBold,size: 13, color:Blue)
                                  )
                              )
                            ]
                        )
                      )
                  ),

                  SizedBox(
                      height: sizePage.height/4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///КНОПКА ДАЛЕЕ
                          ButtonWidget(
                            text: "Далее",
                            func:()=>Validation(),
                          )
                        ]
                      )
                  )
                ]
              )
          ),

          Positioned(
            child: isLoading ? Container(
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Blue)
                )
              ),
              color: Colors.white.withOpacity(0.8),
            ) : Container(),
          ),
        ]
    );
  }

  void Validation() {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
    r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(email == '') {
      setState(()=>errorEmail = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Введите почту',textStyle: Montserrat(size: 15)));
    }
    else if (emailValid == false) {
      setState(()=>errorEmail = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Неверный формат почты',textStyle: Montserrat(size: 15)));
    }
    else{
      setState(() {isLoading = true;});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> SecondStepPage(this.email)));
      setState(() {isLoading = false;});
    }
  }
}

