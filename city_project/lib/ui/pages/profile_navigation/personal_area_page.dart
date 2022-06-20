import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/photo_user_widget.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/verified_user_widget.dart';
import 'package:lan_code/ui/pages/guide/my_excursions_page/my_excursions_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/become_guide_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/widgets/button_social_network_widget.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/service.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/button_profile_style_widget.dart';

class PersonalAreaPage extends StatelessWidget {
  final UserEntity? user;

  PersonalAreaPage(this.user, {Key? key}) : super(key: key);
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: AppBar(
        backgroundColor: Grey,
        elevation: 0.0,
        //actions: [IconButton(icon: iconSetting, onPressed: null)],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(children: [
                          PhotoUserWidget((user?.photo) ?? "null",
                              size: MediaQuery.of(context).size.width / 7),
                          VerifiedUserWidget((user?.verified) ?? false,
                              size: MediaQuery.of(context).size.width / 7,
                              mSize: MediaQuery.of(context).size.width / 7 / 4)
                        ]),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text((user?.name) ?? "Null",
                                  style: Montserrat(style: Bold, color: Blue, size: 24),
                                  textAlign: TextAlign.left),
                              ((user?.verified) ?? false)
                                  ? Text('Личность подтверждена',
                                      style: Montserrat(color: Blue, size: 14))
                                  : RichText(
                                      text: TextSpan(
                                        text: "Подтвердить личность",
                                        style: Montserrat(style: SemiBold, size: 14, color: Red),
                                        recognizer: TapGestureRecognizer()..onTap = null,
                                      ),
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                    /*const ButtonProfileStyleWidget(
                      title: 'Управление профилем',
                      description: 'Доступные проверки и расширения',
                      icon: Icon(Icons.person_outlined, color: Blue, size: 30),
                      func: null,
                    ),*/
                    //Container(height: 1, width: MediaQuery.of(context).size.width, color: Blue),
                    ((user?.guidePermit) ?? false)
                        ? ButtonProfileStyleWidget(
                            title: 'Мои экскурсии',
                            description: 'Экскурсии в которых вы являетесь гидом',
                            icon: Icon(Icons.person_outlined, color: Blue, size: 30),
                            func: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const MyExcursionsPage()),
                            ),
                          )
                        : ButtonProfileStyleWidget(
                            title: 'Стать гидом',
                            description: 'Станьте гидом, чтобы опубликовывать ваши экскурсии',
                            icon: const Icon(
                              Icons.person_outlined,
                              color: Blue,
                              size: 30,
                            ),
                            func: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const BecomeGuidePage()),
                            ),
                          ),
                    /*Container(height: 1, width: MediaQuery.of(context).size.width, color: Blue),
                    const ButtonProfileStyleWidget(
                      title: 'Статистика',
                      description: 'Описание статистики',
                      icon: Icon(Icons.person_outlined, color: Blue, size: 30),
                      func: null,
                    )*/
                  ],
                ),
                Column(
                  children: [
                    const ButtonProfileStyleWidgetEasy(
                      title: 'О приложении',
                      func: null,
                    ),
                    Container(height: 1, width: MediaQuery.of(context).size.width, color: Blue),
                    ButtonProfileStyleWidgetEasy(
                      title: 'Служба поддержки',
                      func: () {
                        showModalBottomSheet(
                            backgroundColor: White.withOpacity(0),
                            context: context,
                            builder: (BuildContext context) => const ShowWeContacts());
                      },
                    ),
                    ButtonWidget(
                      text: "Выйти из аккаута",
                      padding: 0,
                      textColor: White,
                      buttonColor: Red,
                      func: () {
                        authService.layout(context);
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShowWeContacts extends StatelessWidget {
  const ShowWeContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 180,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 25),
          decoration: const BoxDecoration(
              color: Blue,
              borderRadius:
                  BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50))),
          child: Column(children: [
            Text("Служба поддержки", style: Montserrat(color: White, style: SemiBold, size: 15)),
            Container(
                margin: const EdgeInsets.only(top: 5),
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                child: Text("Для решения вопросов, можете связаться с нами лично",
                    style: Montserrat(size: 14, color: White), textAlign: TextAlign.center)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                margin: const EdgeInsets.only(top: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  ButtonSocialNetworkWidget(
                    icon: iconVK,
                    func: () async {
                      launchURL('https://vk.com/astraslan', context);
                    },
                  ),
                  ButtonSocialNetworkWidget(
                      icon: iconWhatsapp,
                      func: () {
                        launchURL('', context);
                      }),
                  ButtonSocialNetworkWidget(
                      icon: iconInstagram,
                      func: () {
                        launchURL('https://www.instagram.com/asl_astro/', context);
                      }),
                  ButtonSocialNetworkWidget(
                      icon: iconTelegram,
                      func: () {
                        launchURL('https://t.me/astroasl', context);
                      })
                ]))
          ])),
      Container(
          alignment: Alignment.topCenter,
          height: 180,
          padding: const EdgeInsets.only(top: 10),
          child: Container(
              width: 50,
              height: 4,
              decoration: const BoxDecoration(
                  color: White, borderRadius: BorderRadius.all(Radius.circular(500)))))
    ]);
  }

  void launchURL(String url, context) async {
    try {
      await launch(url);
    } catch (e) {
      showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: e.toString(),
            textStyle: Montserrat(size: 15, color: White),
            lines: 4,
          ));
    }
  }
}
