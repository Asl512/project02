import 'package:lan_code/back-end/data/repositories/city_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/useCases/city_useCase.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class ListCitiesAction {}

class LoadListCitiesAction extends ListCitiesAction {}

class ErrorListCitiesAction extends ListCitiesAction {}

class GetListCitiesAction extends ListCitiesAction {
  final List<CityEntity> cities;

  GetListCitiesAction({required this.cities});
}

ThunkAction GetListCitiesThunkAction() => (Store store) async {
      store.dispatch(LoadListCitiesAction());

      List<CityEntity>? response = await GetAllCity(CityDataRepository()).call();
      if(response != null){
        if(response.isEmpty){
          store.dispatch(GetListCitiesAction(cities: []));
        }else{
          store.dispatch(GetListCitiesAction(cities: response));
        }
      }else{
        store.dispatch(ErrorListCitiesAction());
      }
    };

abstract class CityAction {}

class LoadCityAction extends CityAction {}

class ErrorCityAction extends CityAction {}

class GetCityAction extends CityAction {
  final CityEntity city;

  GetCityAction({required this.city});
}

ThunkAction GetCityThunkAction() => (Store store) async {
      store.dispatch(LoadCityAction());
      CityEntity? response = await GetCity(CityDataRepository()).call();
      if(response == null){
        store.dispatch(ErrorCityAction());
      }else{
        store.dispatch(GetCityAction(city: response));
      }
    };
