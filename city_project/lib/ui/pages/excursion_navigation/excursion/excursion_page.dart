import 'package:card_swiper/card_swiper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;
import 'reviews.dart';

class ExcursionPage extends StatelessWidget {
  const ExcursionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const _Header(),
          ];
        },
        body: const _Body(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return SliverAppBar(
      backgroundColor: Blue,
      bottom: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          10.0,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            height: 10.0,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: White),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: MediaQuery.of(context).size.height/3,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            ImageBoxWidget(url: _store.state.excursionInfoState.excursion!.photo),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
            ),
            Positioned(
              left: 20.0,
              bottom: 70.0,
              right: 20.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      _store.state.excursionInfoState.excursion!.name.toUpperCase(),
                      style: Montserrat(color: White, size: 25, style: Bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(40)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Stack(
                      children: [
                        PhotoAuthor(_store.state.excursionInfoState.user!.photo),
                        GuideCheck(_store.state.excursionInfoState.user!.verified),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    height: 50,
                    padding: const EdgeInsets.only(right: 15),
                    alignment: Alignment.center,
                    child: Text(
                      _store.state.excursionInfoState.user!.name,
                      style: Montserrat(size: 15, style: SemiBold, color: White),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late double rating;
  late Store<AppState> store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = StoreProvider.of<AppState>(context);
    rating = store.state.excursionInfoState.excursion!.rating.first /
        store.state.excursionInfoState.excursion!.rating.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///РЕЙТИНГ И ОТЗЫВЫ
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingStars(
                          value: rating,
                          starBuilder: (index, color) => Icon(Icons.star, color: color),
                          starSize: 23,
                          maxValueVisibility: false,
                          valueLabelVisibility: false,
                          animationDuration: const Duration(milliseconds: 1000),
                          starOffColor: Colors.black.withOpacity(0.1),
                          starColor: Red,
                        ),
                        Container(
                          child: Text(rating.toStringAsFixed(1),
                              style: Montserrat(color: Blue, size: 18, style: SemiBold)),
                          margin: const EdgeInsets.only(left: 15),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RewiewPage(null),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            0.toString() + " отзывов",
                            style: Montserrat(
                              color: const Color(0xFFF48494a),
                              size: 16,
                              style: Bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFF48494a),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                ///ОПИСАНИЕ
                Text(
                  store.state.excursionInfoState.excursion!.description,
                  style: Montserrat(color: Blue, size: 15),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    spacing: 10,
                    children: store.state.excursionInfoState.excursion!.tags
                        .map(
                          (tag) => InputChip(
                            avatar: Text("#", style: Montserrat(color: Colors.white)),
                            labelStyle: Montserrat(size: 14),
                            backgroundColor: Blue,
                            onSelected: (sel) {},
                            label: Text(tag, style: Montserrat(color: Colors.white)),
                          ),
                        )
                        .toList(),
                  ),
                ),

                ///ОСНОВНАЯ ИНФОРМАЦИЯ
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [ShadowForContainer()],
                          color: White,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    store.state.excursionInfoState.type!.name.split(' ').first +
                                        " экскурсия",
                                    style: Montserrat(size: 16, style: Bold),
                                  ),
                                  Text(
                                    store.state.excursionInfoState.excursion!.duration,
                                    style: Montserrat(size: 16),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Тип передвижения:',
                                      style: Montserrat(size: 14, style: SemiBold),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        store.state.excursionInfoState.excursion!.moveType
                                            .join(', '),
                                        style: Montserrat(size: 14),
                                      ),
                                      width: MediaQuery.of(context).size.width / 2 - 40,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Размер группы:',
                                      style: Montserrat(size: 14, style: SemiBold),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'до ' +
                                            store.state.excursionInfoState.excursion!.groupSize
                                                .toString() +
                                            " человек",
                                        style: Montserrat(size: 14),
                                      ),
                                      width: MediaQuery.of(context).size.width / 2 - 40,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    'Точное место встречи и контакты гида вы узнаете сразу после бронирования.',
                                    style: Montserrat(size: 14, style: Regular),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 0.5,
                              color: Blue.withOpacity(0.5),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "₽ " + 1200.toString(),
                                      style: Montserrat(style: Bold, size: 17, color: Blue)),
                                  TextSpan(
                                    text: " за человека",
                                    style: Montserrat(size: 16, color: Blue),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: TextButton(
                                onPressed: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Booking("dd",widget.data,widget.gid,widget.type)));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Red,
                                    borderRadius: BorderRadius.all(Radius.circular(500)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Бронировать",
                                      style: Montserrat(style: SemiBold, size: 19, color: White),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [ShadowForContainer()],
                            color: Blue,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
                        child: Column(
                          children: [
                            store.state.excursionInfoState.excursion!.moment
                                ? _Status(
                                    icon: iconLightning,
                                    title: "Мгновенное бронирование",
                                    description: "Без ожидания ответа от гида",
                                  )
                                : const _Status(
                                    icon: Icon(Icons.access_time_rounded, color: Red),
                                    title: "Ожидание",
                                    description: "Вы должны будете ожидать ответа гида",
                                  ),
                            const SizedBox(height: 10),
                            const _Status(
                              icon: Icon(
                                Icons.check,
                                color: Red,
                              ),
                              title: "Экскурсия подтверждена",
                              description: "Эта экскурсия проходила успешно более 5 раз",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                ///ПОДРОБНАЯ ИНФОРМАЦИЯ
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Подробнее об экскурсии",
                    style: Montserrat(style: Bold, size: 16, color: Blue),
                  ),
                ),

                _Card(
                  title: "Что включено",
                  description: store.state.excursionInfoState.excursion!.included,
                ),
                Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                _Card(
                  title: "Дополнительные услуги",
                  description: store.state.excursionInfoState.excursion!.addServices,
                ),
                Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                _Card(
                  title: "Организационные детали",
                  description: store.state.excursionInfoState.excursion!.organizationalDetails,
                ),
                Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                const _Card(
                  title: "Правила экскурсии",
                  description: "Правила экскурсии",
                ),

                ///ФОТОГРАФИИ
                PhotosBlock(images: [])
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const _Status({
    Key? key,
    required this.description,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: icon,
        ),
        Column(
          children: [
            Text(
              title,
              style: Montserrat(style: Bold, size: 14, color: White),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                description,
                style: Montserrat(size: 13, color: White),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String description;

  const _Card({Key? key, required this.title, required this.description}) : super(key: key);

  Widget buildList() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
      child: Text(description, style: Montserrat(size: 15, color: Blue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(hasIcon: false),
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Montserrat(style: SemiBold, size: 16, color: Blue)),
            ExpandableIcon(
              theme: const ExpandableThemeData(
                expandIcon: Icons.arrow_forward_ios,
                collapseIcon: Icons.arrow_forward_ios,
                iconRotationAngle: math.pi / 2,
                iconColor: Blue,
              ),
            ),
          ],
        ),
      ),
      collapsed: Container(),
      expanded: buildList(),
    );
  }
}

class PhotosBlock extends StatelessWidget {
  final List images;

  const PhotosBlock({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 10, bottom: 25),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [ShadowForContainer()],
          color: White,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ifMoreOne(context),
      );
    }
  }

  Widget ifMoreOne(context) {
    if (images.length > 1) {
      return Row(
        children: [
          TextButton(
            onPressed: () => showPhotoDialog(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                images[0],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / 3 * 1.5 + 15,
                width: MediaQuery.of(context).size.width / 2.5,
                loadingBuilder:
                    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Placholder(MediaQuery.of(context).size.width / 2.5,
                      MediaQuery.of(context).size.width / 3 * 1.5 + 15);
                },
              ),
            ),
          ),
          ifTwoMore(context)
        ],
      );
    } else {
      return TextButton(
        onPressed: () => showPhotoDialog(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            images[0],
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / 3 * 1.5 + 15,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) return child;
              return Placholder(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.width / 3 * 1.5 + 15,
              );
            },
          ),
        ),
      );
    }
  }

  Widget ifTwoMore(context) {
    if (images.length > 2) {
      return Column(
        children: [
          TextButton(
            onPressed: () => showPhotoDialog(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                images[1],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                width: MediaQuery.of(context).size.width / 2.5,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Placholder(
                    MediaQuery.of(context).size.width / 2.5,
                    MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                  );
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () => showPhotoDialog(context),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    images[2],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                    width: MediaQuery.of(context).size.width / 2.5,
                    loadingBuilder: (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) return child;
                      return Placholder(
                        MediaQuery.of(context).size.width / 2.5,
                        MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text(
                    '+' + (images.length - 2).toString(),
                    style: Montserrat(size: 40, style: SemiBold),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return TextButton(
        onPressed: () => showPhotoDialog(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            images[1],
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / 3 * 1.5 + 15,
            width: MediaQuery.of(context).size.width / 2.5,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) return child;
              return Placholder(
                MediaQuery.of(context).size.width / 2.5,
                MediaQuery.of(context).size.width / 3 * 1.5 + 15,
              );
            },
          ),
        ),
      );
    }
  }

  void showPhotoDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoCarousel(images: images);
      },
    );
  }
}

class PhotoCarousel extends StatefulWidget {
  final List images;

  const PhotoCarousel({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int indexNow = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Swiper(
          onIndexChanged: (index) => setState(() => indexNow = index + 1),
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: InteractiveViewer(
                child: Image.network(
                  widget.images[index],
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(color: White));
                  },
                ),
              ),
            );
          },
          curve: Curves.decelerate,
          indicatorLayout: PageIndicatorLayout.NONE,
          itemCount: widget.images.length,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 13,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: White,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Фотографии с экскурсии',
                      style: Montserrat(style: Bold, size: 17),
                    ),
                    Text(
                      indexNow.toString() + ' из ' + widget.images.length.toString(),
                      style: Montserrat(style: SemiBold, size: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
