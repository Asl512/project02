import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_actions.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class TicketDetailPage extends StatefulWidget {
  final ExcursionEntity excursion;
  final TicketEntity ticket;

  const TicketDetailPage({
    Key? key,
    required this.ticket,
    required this.excursion,
  }) : super(key: key);

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(TicketDetailThunkAction(
      excursion: widget.excursion,
      ticket: widget.ticket,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _Header(excursion: widget.excursion),
          ];
        },
        body: _Body(
          excursion: widget.excursion,
          ticket: widget.ticket,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ExcursionEntity excursion;

  const _Header({
    Key? key,
    required this.excursion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ImageBoxWidget(url: excursion.photo),
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
                      excursion.name.toUpperCase(),
                      style: Montserrat(color: White, size: 25, style: Bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: StoreConnector<AppState, TicketDetailState>(
                converter: (store) => store.state.ticketDetailState,
                builder: (context, store) {
                  if (store.isLoading) return const LoadingWidget();
                  return Row(
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
                            PhotoAuthor(store.guide?.photo ?? 'null'),
                            GuideCheck(store.guide?.verified ?? false),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        height: 50,
                        padding: const EdgeInsets.only(right: 15),
                        alignment: Alignment.center,
                        child: Text(
                          store.guide?.name ?? 'Error',
                          style: Montserrat(size: 15, style: SemiBold, color: White),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ExcursionEntity excursion;
  final TicketEntity ticket;

  const _Body({
    Key? key,
    required this.excursion,
    required this.ticket,
  }) : super(key: key);

  void _launchUrl(url) async {
    final uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double rating = excursion.rating.first / excursion.rating.last;
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
                const SizedBox(height: 10),

                ///ОПИСАНИЕ
                Text(
                  excursion.description,
                  style: Montserrat(color: Blue, size: 15),
                ),

                const SizedBox(height: 10),

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
                          color: Blue,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        child: Text(
                          'Основная информация: ',
                          style: Montserrat(size: 16, color: White),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [ShadowForContainer()],
                          color: White,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      child: StoreConnector<AppState, TicketDetailState>(
                                        converter: (store) => store.state.ticketDetailState,
                                        builder: (context, store) {
                                          if (store.typesMove.isNotEmpty) {
                                            return Text(
                                              store.typesMove
                                                  .map((typeMove) => typeMove.name)
                                                  .toList()
                                                  .join(', '),
                                              style: Montserrat(size: 14),
                                            );
                                          } else {
                                            return Text(
                                              '---',
                                              style: Montserrat(size: 14),
                                            );
                                          }
                                        },
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
                                        'до ${excursion.groupSize} человек',
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
                                      'Место сбора:',
                                      style: Montserrat(size: 14, style: SemiBold),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        excursion.type != '3'
                                            ? excursion.meetPoint
                                            : ticket.userMeetPoint,
                                        style: Montserrat(size: 14),
                                      ),
                                      width: MediaQuery.of(context).size.width / 2 - 40,
                                    ),
                                  ],
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
                                      text: ticket.standardTickets.toString(),
                                      style: Montserrat(style: Bold, size: 15, color: Blue)),
                                  TextSpan(
                                    text: " - Стандартных билетов",
                                    style: Montserrat(size: 13, color: Blue),
                                  ),
                                ],
                              ),
                            ),
                            StoreConnector<AppState, TicketDetailState>(
                              converter: (store) => store.state.ticketDetailState,
                              builder: (context, store) {
                                if (store.categoryPeople.isEmpty) {
                                  return Container();
                                }
                                return Column(
                                  children: [
                                    for (int i = 0; i < store.categoryPeople.length; i++)
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    ticket.specialTickets[i]['tickets'].toString(),
                                                style:
                                                    Montserrat(style: Bold, size: 15, color: Blue)),
                                            TextSpan(
                                              text: " - ${store.categoryPeople[i].name}",
                                              style: Montserrat(size: 13, color: Blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            Container(
                              width: double.infinity,
                              height: 0.5,
                              color: Blue.withOpacity(0.5),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Дата: ',
                                      style: Montserrat(size: 15),
                                    ),
                                    Text(
                                      ticket.getDate,
                                      style: Montserrat(style: Bold, size: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Время: ',
                                      style: Montserrat(size: 15),
                                    ),
                                    Text(
                                      ticket.getTime,
                                      style: Montserrat(style: Bold, size: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///Гид
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [ShadowForContainer()],
                          color: Blue,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        child: Text(
                          'Ваш гид: ',
                          style: Montserrat(size: 16, color: White),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [ShadowForContainer()],
                          color: White,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                        ),
                        child: StoreConnector<AppState, TicketDetailState>(
                          converter: (store) => store.state.ticketDetailState,
                          builder: (context, store) {
                            if (store.isLoading) return const LoadingWidget();
                            if (store.guide == null) {
                              return Text(
                                'Ошибка загрузки гида',
                                style: Montserrat(size: 15, style: SemiBold),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            children: [
                                              PhotoAuthor(store.guide!.photo),
                                              GuideCheck(store.guide!.verified),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            store.guide!.name,
                                            style: Montserrat(size: 15, style: SemiBold),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _launchUrl('tel:${store.guide!.phone}');
                                  },
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  color: Blue.withOpacity(0.5),
                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_rounded,
                                      color: Blue,
                                    ),
                                    const SizedBox(width: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Гид прошел модерацию',
                                            style: Montserrat(size: 15, color: Blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.directions_walk_outlined,
                                      color: Blue,
                                    ),
                                    const SizedBox(width: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Проведенные экскурсии:',
                                              style: Montserrat(size: 15, color: Blue)),
                                          TextSpan(
                                            text: ' ${store.guide!.countCompleted}',
                                            style: Montserrat(style: Bold, size: 17, color: Blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Подробнее об экскурсии",
                    style: Montserrat(style: Bold, size: 16, color: Blue),
                  ),
                ),
                _Card(
                  title: "Что включено",
                  description: excursion.included,
                ),
                Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                _Card(
                  title: "Дополнительные услуги",
                  description: excursion.addServices,
                ),
                Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                _Card(
                  title: "Организационные детали",
                  description: excursion.organizationalDetails,
                ),
                Container(width: double.infinity, height: 0.5, color: Blue.withOpacity(0.5)),
                const _Card(
                  title: "Правила экскурсии",
                  description:
                      "Экскурсия считается забронированной после того, как вы внесете предоплату. Пока вы не внесли предоплату, нужное вам время может быть забронировано другими путешественниками. Бронь важна для того, чтобы гид точно понимал, что вы придете на экскурсию и мог забронировать для вас свое время. В нашем приложении вы оплачиваете 20% стоимости. Подробнее. Хорошие условия возврата При отмене заказа за 48 часов до начала мы вернем предоплату на вашу карту. Подробнее.",
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ButtonWidget(
                    text: "Отменить",
                    buttonColor: Red,
                    padding: 0,
                    func: () {
                      StoreProvider.of<AppState>(context).dispatch(TicketListCancelThunkAction());
                      StoreProvider.of<AppState>(context).dispatch(TicketListActivityThunkAction());
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
