import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';


class MyExcursionsPage extends StatefulWidget {
  const MyExcursionsPage({Key? key}) : super(key: key);

  @override
  State<MyExcursionsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyExcursionsPage> with TickerProviderStateMixin {
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
                    Tab(child: Text("Модерация", style: Montserrat())),
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
            children:  [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'У вас нет активных экскурсий.',
                    style: Montserrat(size: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Нет экскурсий, которые проходят модерацию.',
                    style: Montserrat(size: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Здесь будет хранится история ваших экскурсий.',
                    style: Montserrat(size: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      "МОИ ЭКСКУРСИИ",
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
