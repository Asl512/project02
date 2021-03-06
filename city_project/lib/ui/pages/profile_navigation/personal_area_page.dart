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
                        Stack(
                          children: [
                            PhotoUserWidget((user?.photo) ?? "null",
                                size: MediaQuery.of(context).size.width / 7),
                            VerifiedUserWidget((user?.verified) ?? false,
                                size: MediaQuery.of(context).size.width / 7,
                                mSize: MediaQuery.of(context).size.width / 7 / 4)
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text((user?.name) ?? "Null",
                                  style: Montserrat(style: Bold, color: Blue, size: 24),
                                  textAlign: TextAlign.left),
                              ((user?.verified) ?? false)
                                  ? Text('???????????????? ????????????????????????',
                                      style: Montserrat(color: Blue, size: 14))
                                  : RichText(
                                      text: TextSpan(
                                        text: "?????????????????????? ????????????????",
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
                      title: '???????????????????? ????????????????',
                      description: '?????????????????? ???????????????? ?? ????????????????????',
                      icon: Icon(Icons.person_outlined, color: Blue, size: 30),
                      func: null,
                    ),*/
                    //Container(height: 1, width: MediaQuery.of(context).size.width, color: Blue),
                    ((user?.guidePermit) ?? false)
                        ? ButtonProfileStyleWidget(
                            title: '?????? ??????????????????',
                            description: '?????????????????? ?? ?????????????? ???? ?????????????????? ??????????',
                            icon: const Icon(Icons.person_outlined, color: Blue, size: 30),
                            func: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const MyExcursionsPage()),
                            ),
                          )
                        : ButtonProfileStyleWidget(
                            title: '?????????? ??????????',
                            description: '?????????????? ??????????, ?????????? ???????????????????????????? ???????? ??????????????????',
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
                      title: '????????????????????',
                      description: '???????????????? ????????????????????',
                      icon: Icon(Icons.person_outlined, color: Blue, size: 30),
                      func: null,
                    )*/
                  ],
                ),
                Column(
                  children: [
                    ButtonProfileStyleWidgetEasy(
                      title: '?? ????????????????????',
                      func: () async {
                        final uri = Uri.parse(
                            'https://docs.yandex.ru/docs/view?url=ya-disk-public%3A%2F%2FIF%2BhvQ1wJV3Vs%2BiH8KsfPVkdeamhHqJPyXagjqOpwRDBYH9s25%2FH7mDVsNiSDiqwq%2FJ6bpmRyOJonT3VoXnDag%3D%3D%3A%2F??%20??????????????.docx&name=??%20??????????????.docx');
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    Container(height: 1, width: MediaQuery.of(context).size.width, color: Blue),
                    ButtonProfileStyleWidgetEasy(
                      title: '???????????? ??????????????????',
                      func: () {
                        showModalBottomSheet(
                            backgroundColor: White.withOpacity(0),
                            context: context,
                            builder: (BuildContext context) => const ShowWeContacts());
                      },
                    ),
                    ButtonWidget(
                      text: "?????????? ???? ??????????????",
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
            Text("???????????? ??????????????????", style: Montserrat(color: White, style: SemiBold, size: 15)),
            Container(
                margin: const EdgeInsets.only(top: 5),
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                child: Text("?????? ?????????????? ????????????????, ???????????? ?????????????????? ?? ???????? ??????????",
                    style: Montserrat(size: 14, color: White), textAlign: TextAlign.center)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                margin: const EdgeInsets.only(top: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  ButtonSocialNetworkWidget(
                    icon: iconVK,
                    func: () async {
                      _launchUrl('https://vk.com/astraslan');
                    },
                  ),
                  ButtonSocialNetworkWidget(
                      icon: iconWhatsapp,
                      func: () {
                        _launchUrl('');
                      }),
                  ButtonSocialNetworkWidget(
                      icon: iconInstagram,
                      func: () {
                        _launchUrl('https://www.instagram.com/asl_astro/');
                      }),
                  ButtonSocialNetworkWidget(
                      icon: iconTelegram,
                      func: () {
                        _launchUrl('https://t.me/astroasl');
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

  void _launchUrl(url) async {
    final uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
