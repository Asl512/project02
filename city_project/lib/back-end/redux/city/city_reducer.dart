import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:redux/redux.dart';

Reducer<ListCitiesState> listCitiesReducer = combineReducers([
  TypedReducer<ListCitiesState, LoadListCitiesAction>(_loadListCities),
  TypedReducer<ListCitiesState, ErrorListCitiesAction>(_errorListCities),
  TypedReducer<ListCitiesState, GetListCitiesAction>(_getListCities),
]);

Reducer<CityState> cityReducer = combineReducers([
  TypedReducer<CityState, LoadCityAction>(_loadCity),
  TypedReducer<CityState, ErrorCityAction>(_errorCity),
  TypedReducer<CityState, GetCityAction>(_getCity),
]);

//List cities

ListCitiesState _loadListCities(
  ListCitiesState state,
  LoadListCitiesAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListCitiesState _errorListCities(
  ListCitiesState state,
  ErrorListCitiesAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListCitiesState _getListCities(
  ListCitiesState state,
  GetListCitiesAction action,
) =>
    state.copyWith(
      cities: action.cities,
      isLoading: false,
      isError: false,
    );

//Active city

CityState _loadCity(
  CityState state,
  LoadCityAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

CityState _errorCity(
  CityState state,
  ErrorCityAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

CityState _getCity(
  CityState state,
  GetCityAction action,
) =>
    state.copyWith(
      city: action.city,
      isLoading: false,
      isError: false,
    );
