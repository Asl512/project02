import 'package:flutter/material.dart';
import 'package:lan_code/service.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/profile_navigation/authorization/authorization_page.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/link_to_document_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authorization/registration.dart';
import 'widgets/button_social_network_widget.dart';

class NotAuthProfilePage extends StatelessWidget {
  const NotAuthProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sizePage = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Grey,
      appBar: AppBar(
        backgroundColor: Grey,
        elevation: 0.0,
        //actions: [IconButton(icon: iconSetting, onPressed: null)],
      ),
      body: SizedBox(
        height: sizePage.height - 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iProfil, height: sizePage.height / 2.5, fit: BoxFit.fill),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sizePage.width / 10),
                child: Text(
                  "Авторизуйтесь что бы пользоваться всеми функциями TripTeam.",
                  textAlign: TextAlign.center,
                  style: Montserrat(style: SemiBold, size: 16),
                ),
              ),
              //const _Social(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                      text: "Войти",
                      padding: 0,
                      func: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const AuthorizationPage()))),
                  ButtonWidget(
                      text: "Регистрация",
                      padding: 0,
                      func: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const Registration())))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ListToDocumentWidget(
                  mainText: "При входе, вы принимаете условия пользования сервисом.",
                  func: (){
                    _launchUrl('https://docs.yandex.ru/docs/view?url=ya-disk-public%3A%2F%2FIF%2BhvQ1wJV3Vs%2BiH8KsfPVkdeamhHqJPyXagjqOpwRDBYH9s25%2FH7mDVsNiSDiqwq%2FJ6bpmRyOJonT3VoXnDag%3D%3D%3A%2FУсловия%20использования.docx&name=Условия%20использования.docx&nosw=1');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _Social extends StatelessWidget {
  const _Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late int count = 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonSocialNetworkWidget(
            icon: iconVK,
            func: () async {
              count++;
              AuthService authService = AuthService();
              if (count == 3) {
                await authService.signIn('admin@mail.ru', '123456');
              }
            },
          ),
          ButtonSocialNetworkWidget(icon: iconFacebook, func: null),
          ButtonSocialNetworkWidget(icon: iconGoogle, func: null)
        ],
      ),
    );
  }
}
