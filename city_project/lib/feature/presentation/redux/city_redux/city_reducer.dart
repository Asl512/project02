import 'package:flutter/cupertino.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/actions/city_actions.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/actions/excursion_actions.dart';
import 'package:lan_code/feature/presentation/redux/city_redux/city_state.dart';
import 'package:redux/redux.dart';

CityState cityReducer(CityState state, dynamic action){
  return CityState(
      cities: _citiesReducer(state.cities,action),
      excursions: _excursionsReducer(state.excursions,action),
  );
}

Reducer<Widget> _citiesReducer = combineReducers([
  TypedReducer<Widget,GetCitiesWidgetAction>(_getCitiesReducer),
]);

Reducer<Widget> _excursionsReducer = combineReducers([
  TypedReducer<Widget,GetExcursionsWidgetAction>(_getExcursionsReducer),
]);

Widget _getCitiesReducer(Widget widget, GetCitiesWidgetAction action) => action.widget;

Widget _getExcursionsReducer(Widget widget, GetExcursionsWidgetAction action) => action.widget;