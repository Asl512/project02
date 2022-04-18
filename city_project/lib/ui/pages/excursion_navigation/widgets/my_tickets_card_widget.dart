import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/excursion_card_widget.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/photo_user_widget.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/verified_user_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const _Header(),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Grey,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Blue,
                  tabs: [
                    Tab(child: Text("Активные", style: Montserrat())),
                    Tab(child: Text("Избранные", style: Montserrat())),
                    Tab(child: Text("Отмененные", style: Montserrat())), // ждет 3 табсов
                  ],
                ),
              ),
            ),
          ];
        },
        body: Scaffold(
          backgroundColor: Grey,
          body: TabBarView(
            controller: _tabController,
            children: const [
              _MyTicketsCard(),
              _MyTicketsCard(),
              _MyTicketsCard(),
            ],
          ),
        ),
      ),
    );
  }
}



class _MyTicketsCard extends StatelessWidget {
  const _MyTicketsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 60),
      child: TextButton(
        onPressed: () {},
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
                              style: Montserrat(
                                  size: 15, style: SemiBold, color: White),
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
class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return SliverAppBar(
      backgroundColor: Grey,
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
      expandedHeight: MediaQuery.of(context).size.height / 10,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // ПРОВЕРЬ ВЕРСТКУ
            /*Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
            ),*/
            Positioned(
              left: 20.0,
              bottom: 20.0,
              right: 20.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      ((_store.state.cityState.city?.name) ?? 'Error City Name').toUpperCase(),
                      style: Montserrat(color: Blue, size: 25, style: Bold),
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
