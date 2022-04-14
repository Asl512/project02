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
import 'package:lan_code/ui/pages/excursion_navigation/widgets/photo_user_widget.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/verified_user_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';

class ExcursionCardWidget extends StatelessWidget {
  final ExcursionEntity excursionEntity;
  final UserEntity userEntity;
  final TypeEntity typeEntity;

  const ExcursionCardWidget({
    required this.excursionEntity,
    required this.userEntity,
    required this.typeEntity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 60),
      child: TextButton(
        onPressed: () {
          store.dispatch(
            GetExcursionInfoThunkAction(
              excursion: excursionEntity,
              user: userEntity,
              type: typeEntity,
            ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ExcursionPage()));
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    ImageExcursionHeader(photo: excursionEntity.photo),
                    Container(
                      height: 50,

                      ///сделать размер черной подложки нормальным
                      width: excursionEntity.name.length.toDouble() * 14 + 50 >=
                              MediaQuery.of(context).size.width / 1.4
                          ? MediaQuery.of(context).size.width / 1.4
                          : excursionEntity.name.length.toDouble() * 14 + 50,
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
                                PhotoUserWidget(userEntity.photo),
                                VerifiedUserWidget(userEntity.verified)
                              ],
                            ),
                          ),

                          Flexible(
                            child: Text(
                              excursionEntity.name,
                              style: Montserrat(size: 15, style: SemiBold, color: White),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ///ДОБАВЛЕНИЕ В ИЗБРАННОЕ
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 50,
                    right: MediaQuery.of(context).size.width / 50,
                  ),
                  child: IconButton(
                    icon: iconFavoriteWhite,
                    onPressed: null,
                  ),
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
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              typeEntity.name.split(' ')[0].toString(),
                              style: Montserrat(
                                size: 17,
                                style: SemiBold,
                                color: const Color(0xFF55596A),
                              ),
                            ),
                            excursionEntity.moment
                                ? Container(
                                    width: 17,
                                    height: 17,
                                    margin: const EdgeInsets.only(left: 5),
                                    child: iconLightning,
                                  )
                                : Container()
                          ],
                        ),
                        Flexible(
                          child: Text(
                            excursionEntity.description,
                            style: Montserrat(size: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ///окончания на часах
                      Text(excursionEntity.duration, style: Montserrat(size: 13, style: Regular)),
                      Text('₽ ' + excursionEntity.standardPrice.toString(),
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

class ImageExcursionHeader extends StatelessWidget {
  final String photo;

  const ImageExcursionHeader({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

        ///КАРТИНКА
        ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Image.network(
        photo,
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 10 + 20,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return Placholder(
            double.infinity,
            MediaQuery.of(context).size.height / 10 + 20,
          );
        },
        errorBuilder: (context, error, stackTrace) => Image.asset(
          excursionDef,
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 10 + 20,
        ),
      ),
    );
  }
}
