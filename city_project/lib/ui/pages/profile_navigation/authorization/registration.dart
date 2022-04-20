import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:lan_code/service.dart';


class Registration extends StatefulWidget
{
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool passwordVisible = true;
  bool isChecked = false;
  List errorName = [false,"errorName"];
  List errorPassword = [false,"errorPassword"];
  List errorEmail = [false,"errorEmail"];
  String name = '';
  String email = '';
  String password = '';
  bool isLoading = false;
  AuthService authService = AuthService();

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
                title: Text("Регистрация",style: Montserrat(size: 25,style: Bold)),
              ),

              body: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Container(
                                margin: const EdgeInsets.only(top: 50),
                                padding: EdgeInsets.symmetric(horizontal: sizePage.width / 15),
                                child: Column(
                                    children: [

                                      ///NAME
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const TitleTextFormField(text: "Имя Фамилия:"),
                                            TextFieldWithShadow(
                                              TextFormField(
                                                  style: Montserrat(size: 15),
                                                  initialValue: name,
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      name = value;
                                                      errorName[0] = false;
                                                    });
                                                  },
                                                  decoration: TextFieldDecoration(
                                                      hintText: "Введите ваше имя и фамилию",
                                                      prefixIcon: PrefixIconTextField(color: const Color(0xFFffaf5a),icon: iconMenuProfile)
                                                  ).inputDecoration
                                              ),
                                              errorText: true,
                                              error: errorName,
                                            )
                                          ]
                                      ),

                                      ///EMAIL
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 25),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const TitleTextFormField(text: "Почта:"),
                                              TextFieldWithShadow(
                                                TextFormField(
                                                    style: Montserrat(size: 15),
                                                    initialValue: email,
                                                    onChanged: (String value) {
                                                      setState(() {
                                                        email = value;
                                                        errorEmail[0] = false;
                                                      });
                                                    },
                                                    decoration: TextFieldDecoration(
                                                        hintText: "Введите вашу почту",
                                                        prefixIcon: PrefixIconTextField(color: const Color(0xFF546eff), icon: iconEmail)
                                                    ).inputDecoration
                                                ),
                                                errorText: true,
                                                error: errorEmail,
                                              )
                                            ]
                                        ),
                                      ),

                                      ///PASSWORD
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const TitleTextFormField(text: "Пароль:"),
                                            TextFieldWithShadow(
                                              TextFormField(
                                                  initialValue: password,
                                                  style: Montserrat(size: 15),
                                                  obscureText: passwordVisible,
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      password = value;
                                                      errorPassword[0] = false;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      prefixIcon: PrefixIconTextField(color: const Color(0xFF00f069), icon: iconPassword),
                                                      suffixIcon: Container(
                                                          margin: const EdgeInsets.only(right: 10),
                                                          child: IconButton(
                                                              icon: passwordVisible == true ? iconShow : iconHide,
                                                              onPressed: () {
                                                                setState(() {
                                                                  passwordVisible = !passwordVisible;
                                                                });
                                                              }
                                                          )
                                                      ),

                                                      hintStyle: Montserrat(color: Colors.black26, size: 15),
                                                      hintText: "Придумайте пароль",

                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                          borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                                      ),
                                                      fillColor: White,
                                                      isDense: true,
                                                      filled: true
                                                  )
                                              ),
                                              errorText: true,
                                              error: errorPassword,
                                            )
                                          ]
                                      )
                                    ]
                                )
                            ),
                            ///КНОПКА ЗАРЕГЕСТРИРОВАТЬСЯ
                            Container(
                              margin: const EdgeInsets.only(bottom: 50),
                              child: ButtonWidget(
                                text: "Зарегестрироваться",
                                func: ()=>Validation(),
                              ),
                            ),
                          ]
                      ),
                  ),
                ],
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
          )
        ]
    );
  }

  void Validation()async{
    int countError = 0;
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
      r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (name == '') {
      setState(()=>errorName = [true,"Введите имя"]);
      countError++;
    }
    else if(name.length < 5){
      setState(()=>errorName = [true,"Слишком короткое имя"]);
      countError++;
    }

    if(email == '') {
      setState(()=>errorEmail = [true,"Введите почту"]);
      countError++;
    }
    else if (emailValid == false) {
      setState(()=>errorEmail = [true,"Неверный формат почты"]);
      countError++;
    }

    if(password == ''){
      setState(()=>errorPassword = [true,"Введите пароль"]);
      countError++;
    }
    else if(password.length < 6) {
      setState(()=>errorPassword = [true,"Слишком короткий пароль"]);
      countError++;
    }


      if(countError == 0)
      {
        setState(()=>isLoading = true);

        dynamic user = await authService.register(email.trim(), password.trim());
        if(user == null){
          setState(()=>errorEmail = [true,"починить"]);
          showTopSnackBar(context, CustomSnackBar.error(message:'починить',textStyle: Montserrat(size: 15)));
        }else{
          await FirebaseFirestore.instance.collection('user').add({
            "id": user.id,
            "name":name,
            "verified": false,
            "photo": 'null',
            "guidePermit":false
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Navigation(index: 2)),
                (route) => false,
          );
        }
        setState(() {isLoading = false;});
      }
      else {
        showTopSnackBar(context, CustomSnackBar.error(message:"Ошибка валидации полей",textStyle: Montserrat(size: 15,color: White)));
      }
    }
}