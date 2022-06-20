import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:lan_code/back-end/redux/guide_excursions/guide_active_excursions_action.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/my_excursions_page/card.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';

class MyExcursionsPage extends StatefulWidget {
  const MyExcursionsPage({Key? key}) : super(key: key);

  @override
  State<MyExcursionsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyExcursionsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            if (_store.state.guidActiveExcursions.excursions.isEmpty) {
              _store.dispatch(LoadActivityGuideExcursionsAction());
              _store.dispatch(ActiveExcursionsThunkAction());
            }
            break;
          case 1:
            if (_store.state.guidModerateExcursions.excursions.isEmpty) {
              _store.dispatch(LoadModerateGuideExcursionsAction());
              _store.dispatch(ModerateExcursionsThunkAction());
            }
            break;
        }
      }
    });

    if (_store.state.guidActiveExcursions.excursions.isEmpty) {
      _store.dispatch(LoadActivityGuideExcursionsAction());
      _store.dispatch(ActiveExcursionsThunkAction());
    }
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
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ActiveTab(storeApp: _store),
              ModerateTab(storeApp: _store),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveTab extends StatelessWidget {
  final Store storeApp;

  const ActiveTab({Key? key, required this.storeApp}) : super(key: key);

  void refresh() {
    storeApp.dispatch(LoadActivityGuideExcursionsAction());
    storeApp.dispatch(ActiveExcursionsThunkAction());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Blue,
      onRefresh: () => Future(() => refresh()),
      child: StoreConnector<AppState, ListExcursionsState>(
        converter: (store) => store.state.guidActiveExcursions,
        builder: (context, store) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else if (store.isError) {
            return PageReloadWidget(
              errorText: 'Ошибка загрузки экскурсий',
              func: refresh,
            );
          }
          if (store.excursions.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'У вас нет активных экскурсий.',
                  style: Montserrat(size: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: store.excursions.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              return CardExcursion(
                excursion: store.excursions[index],
              );
            },
          );
        },
      ),
    );
  }
}

class ModerateTab extends StatelessWidget {
  final Store storeApp;

  const ModerateTab({Key? key, required this.storeApp}) : super(key: key);

  void refresh() {
    storeApp.dispatch(LoadModerateGuideExcursionsAction());
    storeApp.dispatch(ModerateExcursionsThunkAction());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Blue,
      onRefresh: () => Future(() => refresh()),
      child: StoreConnector<AppState, ListExcursionsState>(
        converter: (store) => store.state.guidModerateExcursions,
        builder: (context, store) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else if (store.isError) {
            return PageReloadWidget(
              errorText: 'Ошибка загрузки экскурсий',
              func: refresh,
            );
          }
          if (store.excursions.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Нет экскурсий, которые проходят модерацию.',
                  style: Montserrat(size: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: store.excursions.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              return CardExcursion(
                excursion: store.excursions[index],
              );
            },
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Blue,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "МОИ ЭКСКУРСИИ",
        style: Montserrat(color: Blue, size: 25, style: Bold),
      ),
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
    );
  }
}
