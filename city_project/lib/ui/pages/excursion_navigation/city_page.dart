import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/excursion_card_widget.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';
import 'search_page.dart';

class CityPage extends StatefulWidget {

  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> with TickerProviderStateMixin {
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
                    Tab(child: Text("Все", style: Montserrat())),
                    Tab(child: Text("Групповые", style: Montserrat())),
                    Tab(child: Text("Индивидуальные", style: Montserrat())),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Scaffold(
          backgroundColor: Grey,
          body: TabBarView(controller: _tabController, children: const [
            _BodyExcursions(),
            _BodyExcursions(type: '12'),
            _BodyExcursions(type: '3'),
          ]),
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
      expandedHeight: MediaQuery.of(context).size.height/10,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            ImageBoxWidget(url: ((_store.state.cityState.city?.photo) ?? 'null')),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
            ),
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
                      style: Montserrat(color: White, size: 25, style: Bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: iconMagnifier,
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

class _BodyExcursions extends StatefulWidget {
  final String? type;

  const _BodyExcursions({
    this.type,
    Key? key,
  }) : super(key: key);

  @override
  State<_BodyExcursions> createState() => _BodyExcursionsState();
}

class _BodyExcursionsState extends State<_BodyExcursions> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(GetListExcursionsThunkAction(type: widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Blue,
      onRefresh: () => Future(() {
        _store.dispatch(GetListExcursionsThunkAction(type: widget.type));
      }),
      child: StoreConnector<AppState, ListExcursionsState>(
        converter: (store) => store.state.listExcursionsState,
        builder: (context, store) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else if (store.isError) {
            return const PageReloadWidget('Ошибка загрузки экскурсий');
          }
          if (store.excursions.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.25,
              child: Center(
                child: Text(
                  'Экскурсии не найдены',
                  style: Montserrat(style: Bold, size: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          List<Widget> _excursionsCard = [];
          for (int i = 0; i < store.excursions.length; i++) {
            _excursionsCard.add(ExcursionCardWidget(
              excursionEntity: store.excursions[i],
              userEntity: store.users[i],
              typeEntity: store.types[i],
            ));
          }
          return ListView(children: _excursionsCard);
        },
      ),
    );
  }
}
