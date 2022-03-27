import 'package:flutter/material.dart';
import 'package:lan_code/feature/presentation/pages/profile_navigation/authorization/authorization_page.dart';
import 'package:lan_code/feature/presentation/widgets/button_widget.dart';

import '../../../../common/colors.dart';
import '../../../../common/icons.dart';
import '../../../../common/images.dart';
import '../../../../common/textStyle.dart';
import 'authorization/registration.dart';
import 'widgets/button_social_network_widget.dart';

class NotAuthProfilePage extends StatelessWidget{
  const NotAuthProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sizePage = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Grey,

        appBar: AppBar(
            backgroundColor:Grey,
            elevation: 0.0,
            actions: [
              IconButton(
                  icon: iconSetting,
                  onPressed:null
              )
            ]
        ),

        body:Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    iProfil,
                    width: sizePage.width/1.3,
                    height: sizePage.width/1.3,
                    fit:BoxFit.fill
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: sizePage.width/10),
                  child:Text(
                      "Авторизуйтесь что бы пользоваться всеми функциями TripTeam.",
                      textAlign: TextAlign.center,
                      style: Montserrat(style: SemiBold,size: 16)
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ButtonWidget(
                    text: "Авторизоваться",
                    func: (){
                      showModalBottomSheet<void>(
                          backgroundColor:White.withOpacity(0),
                          context: context,
                          builder: (BuildContext context)=> const ShowDialogAuthorization()
                      );}
                  ),
                ),
              ]
          )
        )
    );
  }
}

class ShowDialogAuthorization extends StatelessWidget {
  const ShowDialogAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.only(top:25),
            decoration: const BoxDecoration(
                color: Blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)
                )
            ),
            child: Column(
                children: [
                  Text("Авторизоваться",style: Montserrat(color:White,style: SemiBold,size: 15)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
                    margin: const EdgeInsets.only(top: 10,bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonSocialNetworkWidget(icon: iconVK,func: null),
                        ButtonSocialNetworkWidget(icon: iconFacebook,func: null),
                        ButtonSocialNetworkWidget(icon: iconGoogle,func: null)
                      ]
                    )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(
                        text: "Войти",
                        textColor: Blue,
                        padding: 0,
                        buttonColor: White,
                        func: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> const AuthorizationPage())),
                      ),

                      ButtonWidget(
                        text: "Регистрация",
                        padding: 0,
                        textColor: Blue,
                        buttonColor: White,
                        func: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> const Registration())),
                      )
                    ]
                  )
                ]
            )
          ),

          Container(
            alignment: Alignment.topCenter,
            height: 200,
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 50,
              height: 4,
              decoration: const BoxDecoration(
                  color: White,
                  borderRadius: BorderRadius.all(Radius.circular(500))
              )
            ),
          )
        ]
    );
  }
}
