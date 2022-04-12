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
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';
import 'search_page.dart';

class CityPage extends StatefulWidget {
  final CityEntiti? _cityEntiti;

  const CityPage(this._cityEntiti, {Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  final List<String> _titleTabs = ['Все', 'Групповые', 'Индивидуальные'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: AppBar(
        backgroundColor: Grey,
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            ((widget._cityEntiti?.name) ?? 'Error City'),
            style: Montserrat(color: Blue, size: 25, style: Bold),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: iconMagnifier,
            ),
          ),
          const SizedBox(width: 15),
        ],
        centerTitle: false,
        titleSpacing: 0.0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Blue,
          tabs: _titleTabs
              .map(
                (tab) => Tab(
                  child: Text(
                    tab,
                    style: Montserrat(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: RequestExcursion(),
      ),
    );
  }

  List<Widget> RequestExcursion() {
    List<Widget> widgets = [
      const _BodyExcursions(),
      const _BodyExcursions(type: '12'),
      const _BodyExcursions(type: '3'),
    ];
    return widgets;
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
    return StoreConnector<AppState, ListExcursionsState>(
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
              excursionEntiti: store.excursions[i],
              userEntity: store.users[i],
              typeEntity: store.types[i],
            ));
          }
          return Column(children: _excursionsCard);
        });
  }
}
