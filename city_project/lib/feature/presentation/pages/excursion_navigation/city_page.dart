import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/feature/domain/entities/city_entity.dart';
import 'package:lan_code/feature/presentation/pages/excursion_navigation/widgets/background_picture_widget.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/actions/excursion_actions.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/city_reducer.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/city_state.dart';
import 'package:lan_code/feature/presentation/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../../common/colors.dart';
import '../../../../common/icons.dart';
import '../../../../common/images.dart';
import '../../../../common/textStyle.dart';
import 'search_page.dart';


class CityPage extends StatelessWidget {
  final CityEntiti? cityEntiti;
  const CityPage(this.cityEntiti,{Key? key}) : super(key: key);

  static final Store<CityState> store = Store(
      cityReducer,
      middleware: [thunkMiddleware],
      initialState: CityState(
        cities: const PageReloadWidget("Ошибка попробуйте позже"),
        excursions: const PageReloadWidget("Ошибка попробуйте позже"),
      )
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        initialRoute: "/body",
        routes:
        {
          '/body': (context) =>  BodyCityPage(cityEntiti),
          '/search': (context) =>  const SearchPage(),
        },
      ),
    );
  }
}


class BodyCityPage extends StatefulWidget {
  final CityEntiti? _cityEntiti;
  const BodyCityPage(this._cityEntiti,{Key? key}) : super(key: key);


  @override
  State<BodyCityPage> createState() => _BodyCityPagePageState();
}

class _BodyCityPagePageState extends State<BodyCityPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  final List<String> _titleTabs = ['Все','Групповые','Индивидуальные'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 5),
          child: AppBar(
            flexibleSpace: Stack(
                children:[
                  BackgroundPictureWidget(
                    url: widget._cityEntiti!.photo,
                    def: cityDef,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                ((widget._cityEntiti?.name)??'Error City').toUpperCase(),
                                style: Montserrat(color: White, size: 35, style: Bold)
                            )
                          ),
                          TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/search'),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Blue,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: iconMagnifier
                              )
                          )
                        ],
                      )
                  )
                ]
            ),
            centerTitle: false,
            titleSpacing: 0.0,
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: White,
              tabs: _titleTabs.map((tab) => Tab(
                  child: Text(tab,style: Montserrat(color:White,size: 15))
              )).toList(),
            ),
          )
      ),

      body: TabBarView(
        controller: _tabController,
        children: RequestExcursion(),
      ),
    );
  }

  List<Widget> RequestExcursion(){
    List<Widget> widgets = [BodyAllExcursions(),BodyByTypeExcursions(1),BodyByTypeExcursions(2)];
    return widgets;
  }
}

class BodyAllExcursions extends StatelessWidget {
  const BodyAllExcursions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<CityState> store = StoreProvider.of<CityState>(context);
    store.dispatch(GetExcursionsThunkAction());
    return StoreConnector<CityState,CityState>(
        converter: (store) =>store.state,
        builder: (context, store) => store.excursions
    );
  }
}

class BodyByTypeExcursions extends StatelessWidget {
  final int type;
  const BodyByTypeExcursions(this.type,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<CityState> store = StoreProvider.of<CityState>(context);
    store.dispatch(GetExcursionsByTypeThunkAction(type));
    return StoreConnector<CityState,CityState>(
        converter: (store) =>store.state,
        builder: (context, store) => store.excursions
    );
  }
}
