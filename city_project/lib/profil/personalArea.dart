import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../assets/style.dart';
import '../assets/finally.dart';

import '../service.dart';
import 'settings.dart';

class personalArea extends StatelessWidget {
  dynamic user;
  personalArea(this.user);
  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(50),
          child: AppBar(backgroundColor:Grey, elevation: 0.0,
            actions: [
              Container(
                child: IconButton(icon: iconSetting,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Local()));
                  },),
              )
            ],
          )
      ),

      body: ListView(shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 150,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                        width: double.infinity,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(children: [
                              ClipRRect(borderRadius: BorderRadius.all(Radius.circular(500)),
                                child: PhotoAuthor(user!['photo'],size: MediaQuery.of(context).size.width/7),
                              ),
                              GuideCheck(this.user!["verified"]??false,MediaQuery.of(context).size.width/7)
                            ]),
                            Container(margin: EdgeInsets.only(left: 20),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(user!['name'].toString(), style: Montserrat(style: Bold, color: Blue, size: 24), textAlign: TextAlign.left),
                                      CheckStatus(this.user!["verified"]??false)
                                    ]
                                )
                            )
                          ],
                        )
                    ),

                    TextButton(onPressed:(){},
                        child: ButtonProfilStyle('Управление профилем','Доступные проверки и расширения',
                            Icon(Icons.person_outlined, color: Blue,size: 30,)
                        )
                    ),
                    Container(height: 1,width: MediaQuery.of(context).size.width, color: Blue),
                    ButtonForGuid(this.user!["guidePermit"]),
                    Container(height: 1,width: MediaQuery.of(context).size.width, color: Blue),
                    TextButton(onPressed:(){},
                        child: ButtonProfilStyle('Статистика','Описание статистики',
                            Icon(Icons.person_outlined, color: Blue,size: 30,)
                        )
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(onPressed:(){},
                        child: ButtonProfilStyleEazy('О приложении')
                    ),
                    Container(height: 1,width: MediaQuery.of(context).size.width, color: Blue),
                    TextButton(onPressed:(){},
                        child: ButtonProfilStyleEazy('Служба поддержки')
                    ),
                    TextButton(onPressed: (){
                      authService.loyaut();
                    },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(color: Red,
                                borderRadius: BorderRadius.all(Radius.circular(500))),
                            child: Center(child: Text("Выйти из аккаута", style: Montserrat(style: SemiBold,size: 19,color: White)))
                        )
                    )
                  ],
                )
              ],
            ),
          )
      ],
      )
    );
  }
  Widget GuideCheck(bool check,double size){
    if(check)
    {
      return Container(width: size,height: size,
          alignment: Alignment.bottomRight,
          child: Container(width: size/4,height: size/4,
              child: iconConfirmation)
      );
    }
    else return Container();
  }

  Widget CheckStatus(bool check){
    if(check) return Text('Личность подтверждена', style: Montserrat(color: Blue, size: 14));
    else return RichText(
      text: TextSpan(text: "Подтвердить личность", style: Montserrat(style: SemiBold,size: 14, color:Red),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            print('+');
          })
    );
  }

  Widget ButtonForGuid(bool check){
    if(check){
      return TextButton(onPressed:(){},
          child: ButtonProfilStyle('Мои экскурсии','Экскурсии в которых вы являетесь гидом',
              Icon(Icons.person_outlined, color: Blue,size: 30,)
          )
      );
    }else{
      return TextButton(onPressed:(){},
          child: ButtonProfilStyle('Стать гидом','Станьте гидом, чтобы опубликовывать ваши экскурсии',
              Icon(Icons.person_outlined, color: Blue,size: 30,)
          )
      );
    }
  }
}

class ButtonProfilStyle extends StatelessWidget{

  String title = 'Title';
  String discription = 'Discription';
  Widget icon = Icon(Icons.ten_k);
  ButtonProfilStyle(this.title,this.discription,this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(margin: EdgeInsets.only(right: 10),
              child: this.icon,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.title, style: Montserrat(style: SemiBold, color: Blue, size: 16)),
                Container(width: MediaQuery.of(context).size.width/1.5,
                  child: Text(this.discription, style: Montserrat(color: Blue, size: 14))
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios,color: Blue)
          ],
        )
    );
  }
}

class ButtonProfilStyleEazy extends StatelessWidget{

  String title = 'Title';
  ButtonProfilStyleEazy(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.title, style: Montserrat(style: SemiBold, color: Blue, size: 16)),
            Icon(Icons.arrow_forward_ios,color: Blue)
          ],
        )
    );
  }
}


