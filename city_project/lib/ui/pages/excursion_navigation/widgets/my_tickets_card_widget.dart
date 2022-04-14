import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/excursion/excursion_page.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/excursion_card_widget.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/photo_user_widget.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/verified_user_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';

class MyTicketsCard extends StatelessWidget {

  const MyTicketsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 60),
      child: TextButton(
        onPressed: () {
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    ImageExcursionHeader(photo: "null"),
                    Container(
                      height: 50,

                      ///сделать размер черной подложки нормальным
                      width: "Podlozka".length.toDouble() * 14 + 50 >=
                              MediaQuery.of(context).size.width / 1.4
                          ? MediaQuery.of(context).size.width / 1.4
                          : "Podlozka".length.toDouble() * 14 + 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///АВАТАР
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(
                              children: [
                                PhotoUserWidget("PhotoUser"),
                                VerifiedUserWidget(true)
                              ],
                            ),
                          ),

                          Flexible(
                            child: Text(
                              "NameExcursion",
                              style: Montserrat(size: 15, style: SemiBold, color: White),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            ///ОПИСАНИЕ
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              height: 68,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: White,
                boxShadow: [ShadowForContainer()],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Moscow",
                              style: Montserrat(
                                size: 17,
                                style: SemiBold,
                                color: const Color(0xFF55596A),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            "Описание",
                            style: Montserrat(size: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ///окончания на часах
                      Text('12.09.2022',
                          style: Montserrat(size: 16, style: Bold)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}