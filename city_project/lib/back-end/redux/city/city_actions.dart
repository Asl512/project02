import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/data/repositories/city_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/useCases/city_useCase.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class ListCitiesAction {}

class LoadListCitiesAction extends ListCitiesAction {}

class ErrorListCitiesAction extends ListCitiesAction {}

class GetListCitiesAction extends ListCitiesAction {
  final List<CityEntiti> cities;

  GetListCitiesAction({required this.cities});
}

ThunkAction GetListCitiesThunkAction() => (Store store) async {
      store.dispatch(LoadListCitiesAction());

      dynamic response = await GetAllCity(CityDataRepository()).call();
      if (response is Right) {
        store.dispatch(GetListCitiesAction(cities: response.value as List<CityEntiti>));
      } else {
        store.dispatch(ErrorListCitiesAction());
      }
    };

abstract class CityAction {}

class LoadCityAction extends CityAction {}

class ErrorCityAction extends CityAction {}

class GetCityAction extends CityAction {
  final CityEntiti city;

  GetCityAction({required this.city});
}

ThunkAction GetCityThunkAction() => (Store store) async {
      store.dispatch(LoadCityAction());
      dynamic response = await GetCity(CityDataRepository()).call();
      if (response is Right) {
        store.dispatch(GetCityAction(city: response.value as CityEntiti));
      } else {
        store.dispatch(ErrorCityAction());
      }
    };
