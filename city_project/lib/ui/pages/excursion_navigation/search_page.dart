import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/widgets/city_card.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
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
      backgroundColor: Grey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
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
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: _Search(),
              ),
            ),
          ];
        },
        body: Scaffold(
          backgroundColor: Grey,
          body: Column(
            children: const [
              _Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextFieldWithShadow(
        TextField(
          style: Montserrat(color: Blue, size: 15),
          decoration: TextFieldDecoration(
            hintText: 'Введите название города',
            prefixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Blue,
                ),
                width: 40,
                padding: const EdgeInsets.all(6),
                child: iconMagnifier),
          ).inputDecoration,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Blue,
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
            children: store.cities.map((city) => CityCardWidget(cityEntiti: city)).toList(),
          );
        },
      ),
    );
  }
}
