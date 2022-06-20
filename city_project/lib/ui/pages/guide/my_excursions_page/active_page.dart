import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/record/actions.dart';
import 'package:lan_code/back-end/redux/record/state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class ActivePage extends StatelessWidget {
  final ExcursionEntity excursion;

  const ActivePage({
    Key? key,
    required this.excursion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _Header(excursion: excursion),
          ];
        },
        body: _Body(excursion: excursion),
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
          ],
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final ExcursionEntity excursion;

  const _Body({
    Key? key,
    required this.excursion,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late Store<AppState> store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = StoreProvider.of<AppState>(context);
    store.dispatch(RecordListThunkAction(excursion: widget.excursion));
  }

  void refresh() {
    store.dispatch(RecordListThunkAction(excursion: widget.excursion));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: RefreshIndicator(
        color: Blue,
        onRefresh: () => Future(() => refresh()),
        child: StoreConnector<AppState, RecordListState>(
          converter: (store) => store.state.recordListState,
          builder: (context, RecordListState state) {
            if (state.isLoading) {
              return const LoadingWidget();
            } else if (state.isError) {
              return PageReloadWidget(
                errorText: 'Ошибка загрузки данных',
                func: refresh,
              );
            }
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Записи на экскурсию:",
                          style: Montserrat(style: Bold, size: 16, color: Blue),
                        ),
                      ),
                      for (int i = 0; i < widget.excursion.dates.length; i++)
                        _Card(
                          date: widget.excursion.dates[i],
                          record: state.records[i],
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final DateExcursion date;
  final Record record;

  const _Card({
    Key? key,
    required this.date,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(hasIcon: false),
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Дата: ${date.getDate}, Время: ${date.getTime}',
              style: Montserrat(style: SemiBold, size: 16, color: Blue),
            ),
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
      expanded: Column(
        children: [
          if(record.tickets.isEmpty)
            Center(
              child: Text(
                'Пока никто не записался',
                style: Montserrat(size: 15, style: SemiBold),
              ),
            )
          else
          for (int i = 0; i < record.tickets.length; i++)
            GestureDetector(
              child: Container(
                color: Grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            PhotoAuthor(record.users[i].photo),
                            GuideCheck(record.users[i].verified),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          record.users[i].name,
                          style: Montserrat(size: 15, style: SemiBold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${record.tickets[i].getTickets} билета',
                          style: Montserrat(size: 12),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward,
                          color: Blue,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                _showUserContacts(
                  context: context,
                  ticket: record.tickets[i],
                  categories: record.categoryPeople[i],
                );
              },
            ),
        ],
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

  void _showUserContacts({
    required BuildContext context,
    required TicketEntity ticket,
    required List<CategoryPeopleEntity> categories,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Container(
                width: 40,
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.phone,
                  color: White,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF00f069),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              title: Text(
                ticket.phoneUser,
                style: Montserrat(),
              ),
              onTap: () {
                _launchUrl('tel:${ticket.phoneUser}');
              },
            ),
            ListTile(
              leading: Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(6),
                child: Text(
                  ticket.standardTickets.toString(),
                  style: Montserrat(style: Bold, color: White, size: 20),
                ),
                decoration: const BoxDecoration(
                  color: Blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              title: Text(
                'Стандартных билетов',
                style: Montserrat(),
              ),
            ),
            for (int i = 0; i < categories.length; i++)
              ListTile(
                leading: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    ticket.specialTickets[i]['tickets'].toString(),
                    style: Montserrat(style: Bold, color: White, size: 20),
                  ),
                  decoration: const BoxDecoration(
                    color: Blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                title: Text(
                  'Билетов - ${categories[i].name}',
                  style: Montserrat(),
                ),
              ),
          ],
        );
      },
    );
  }
}
