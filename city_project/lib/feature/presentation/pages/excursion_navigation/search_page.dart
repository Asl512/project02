import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/common/colors.dart';
import 'package:lan_code/common/textStyle.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/actions/city_actions.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/city_state.dart';
import 'package:redux/redux.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<CityState> store = StoreProvider.of<CityState>(context);
    store.dispatch(GetCitiesThunkAction());
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
                onPressed: () => Navigator.pop(context)),
            title: Text("Поиск",
                style: Montserrat(color: Blue, size: 25, style: Bold)),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    StoreConnector<CityState, CityState>(
                        converter: (store) => store.state,
                        builder: (context, store) => store.cities
                    ),
                  ]
              )
          )
        ],
      ),
    );
  }
}
