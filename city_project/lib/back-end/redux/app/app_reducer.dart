import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_reducer.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_reducer.dart';
import 'package:lan_code/back-end/redux/excursion/excursions_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_reducer.dart';
import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:lan_code/back-end/redux/user/user_reducer.dart';

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
  } else if (action is ExcursionInfoAction) {
    final nextState = excursionInfoReducer(state.excursionInfoState, action);
    return state.copyWith(excursionInfoState: nextState);
  } else if (action is AuthAction) {
    final nextState = authReducer(state.authState, action);
    return state.copyWith(authState: nextState);
  } else if (action is AddExcursionAction) {
    final nextState = addExcursionReducer(state.addExcursionState, action);
    return state.copyWith(addExcursionState: nextState);
  } else if (action is InsertedExcursionAction) {
    final nextState = insertExcursionReducer(state.insertExcursionState, action);
    return state.copyWith(insertExcursionState: nextState);
  }

  return state;
}
