import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/repositories/city_data_repository.dart';
import 'package:lan_code/feature/domain/entities/city_entity.dart';
import 'package:lan_code/feature/presentation/pages/excursion_navigation/widgets/city_card.dart';
import 'package:lan_code/feature/presentation/widgets/loading_widget.dart';
import 'package:lan_code/feature/presentation/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class GetCitiesWidgetAction{
  final Widget widget;
  GetCitiesWidgetAction({required this.widget});
}

ThunkAction GetCitiesThunkAction() => (Store store)async{
  store.dispatch(GetCitiesWidgetAction(widget: _loadingWidget()));

  dynamic response = await CityDataRepository().getAllCity();
  if(response is Right){
    store.dispatch(GetCitiesWidgetAction(widget: _getCitiesWidgets((response.value as List<CityEntiti>))));
  }else{
    store.dispatch(GetCitiesWidgetAction(widget: _errorWidgets((response.value as ServerFailure).error)));
  }
};

Widget _loadingWidget(){
  return const LoadingWidget();
}

Widget _getCitiesWidgets(List<CityEntiti> cities){
  return Column(
    children: cities.map((city) => CityCardWidget(cityEntiti: city)).toList(),
  );
}

Widget _errorWidgets(String error){
  return PageReloadWidget(error);
}