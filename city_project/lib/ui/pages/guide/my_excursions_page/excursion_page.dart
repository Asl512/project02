import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/excursion/general_information.dart';
import 'package:lan_code/ui/pages/excursion_navigation/excursion/photo_block.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;
import 'package:lan_code/ui/pages/excursion_navigation/excursion/reviews_page.dart';

class ExcursionClientsList extends StatelessWidget {
  const ExcursionClientsList({Key? key}) : super(key: key);

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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: White),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: MediaQuery.of(context).size.height / 3,
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
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Text(
                            "Клиентов ",
                            style: Montserrat(style: Bold, size: 16, color: Blue),
                          ),
                        Container(
                          width: 30,
                          height: 60,
                          alignment: Alignment.center,
                              child: Text(
                                  "4",
                                  style: TextStyle(fontSize: 18)
                              ),
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder (
                                  side: BorderSide(
                                      width: 3,
                                      color: Blue
                                  )
                              )
                          )
                      )
                        ],
                        ),
                        _Card(
                          title: "Кто записался",
                          description: "Василий Петрович\nИван Иванов\nСаня Шима\nДуня Кулакова",
                        ),
                        Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    ///РЕЙТИНГ
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

                    ///ОТЗЫВ
                    const _ReviewButton(),
                  ],
                ),

                ///ОПИСАНИЕ
                Text(
                  store.state.excursionInfoState.excursion!.description,
                  style: Montserrat(color: Blue, size: 15),
                ),

                ///ТЭГИ
                const _Tags(),

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
                  description:
                      "Экскурсия считается забронированной после того, как вы внесете предоплату. Пока вы не внесли предоплату, нужное вам время может быть забронировано другими путешественниками. Бронь важна для того, чтобы гид точно понимал, что вы придете на экскурсию и мог забронировать для вас свое время. В нашем приложении вы оплачиваете 20% стоимости. Подробнее. Хорошие условия возврата При отмене заказа за 48 часов до начала мы вернем предоплату на вашу карту. Подробнее.",
                ),

                ///ФОТОГРАФИИ
                const PhotoBlock(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExcursionInfoState>(
      converter: (store) => store.state.excursionInfoState,
      builder: (context, store) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            spacing: 10,
            children: store.tags
                .map(
                  (tag) => InputChip(
                    avatar: Text("#", style: Montserrat(color: White)),
                    labelStyle: Montserrat(size: 14),
                    backgroundColor: Blue,
                    onSelected: (sel) {},
                    label: Text(tag.name, style: Montserrat(color: White)),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _ReviewButton extends StatelessWidget {
  const _ReviewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExcursionInfoState>(
      converter: (store) => store.state.excursionInfoState,
      builder: (context, store) {
        return TextButton(
          onPressed: () {
            if (store.reviews != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewPage()),
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (store.reviews?.length.toString() ?? '-') + " отзывов",
                style: Montserrat(
                  color: const Color(0xFFF48494a),
                  size: 16,
                  style: Bold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFF48494a),
              ),
            ],
          ),
        );
      },
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
    return description != 'null'
        ? ExpandablePanel(
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
          )
        : Container();
  }
}
