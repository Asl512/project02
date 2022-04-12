import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/city_card.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(GetListCitiesThunkAction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Grey,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20, color: Blue),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              "Поиск",
              style: Montserrat(color: Blue, size: 25, style: Bold),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RefreshIndicator(
                  onRefresh: () => Future(() {
                    final store = StoreProvider.of<AppState>(context);
                    store.dispatch(GetListCitiesThunkAction());
                  }),
                  child: StoreConnector<AppState, ListCitiesState>(
                    converter: (store) => store.state.listCitiesState,
                    builder: (context, store) {
                      if (store.isLoading) {
                        return const LoadingWidget();
                      } else if (store.isError) {
                        return const PageReloadWidget('Ошибка получения городов');
                      }
                      if (store.cities.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.25,
                          child: Center(
                            child: Text(
                              'Города не найдены',
                              style: Montserrat(style: Bold, size: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children:
                        store.cities.map((city) => CityCardWidget(cityEntiti: city)).toList(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
