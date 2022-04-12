import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_reducer.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ListCitiesAction) {
    final nextState = listCitiesReducer(state.listCitiesState, action);
    return state.copyWith(listCitiesState: nextState);
  } else if (action is CityAction) {
    final nextState = cityReducer(state.cityState, action);
    return state.copyWith(cityState: nextState);
  } else if (action is CityAction) {
    final nextState = cityReducer(state.cityState, action);
    return state.copyWith(cityState: nextState);
  } else if (action is ListExcursionsAction) {
    final nextState = listExcursionsReducer(state.listExcursionsState, action);
    return state.copyWith(listExcursionsState: nextState);
  }

  return state;
}
