import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../data/repositories/currency_data_repository.dart';
import '../../data/repositories/excursion_data_repository.dart';
import '../../data/repositories/type_data_repository.dart';
import '../../domain/entities/excursion_entity.dart';
import '../../domain/useCases/currency_useCase.dart';
import '../../domain/useCases/type_useCase.dart';

abstract class ActivityGuideExcursionsAction {}

class LoadActivityGuideExcursionsAction extends ActivityGuideExcursionsAction {}

class ErrorActivityGuideExcursionsAction extends ActivityGuideExcursionsAction {}

class ShowActivityGuideExcursionsAction extends ActivityGuideExcursionsAction {
  final List<ExcursionEntity> excursions;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currency;

  ShowActivityGuideExcursionsAction({
    required this.excursions,
    required this.types,
    required this.currency,
  });
}

ThunkAction ActiveExcursionsThunkAction() => (Store store) async {
      store.dispatch(LoadActivityGuideExcursionsAction);
      List<ExcursionEntity>? excursions =
          await ExcursionDataRepository().getActiveExcursionByGuide(store.state.authState.token);
      if (excursions != null) {
        if (excursions.isEmpty) {
          store.dispatch(ShowActivityGuideExcursionsAction(
            excursions: [],
            types: [],
            currency: [],
          ));
        } else {
          Map<String, List> data = await getDataExcursion(excursions);
          if (data["types"]!.length != excursions.length ||
              data["currencies"]!.length != excursions.length) {
            store.dispatch(ErrorActivityGuideExcursionsAction());
          } else {
            store.dispatch(ShowActivityGuideExcursionsAction(
              excursions: excursions,
              types: data["types"] as List<TypeEntity>,
              currency: data["currencies"] as List<CurrencyEntity>,
            ));
          }
        }
      } else {
        store.dispatch(ErrorActivityGuideExcursionsAction());
      }
    };

Future<Map<String, List>> getDataExcursion(List<ExcursionEntity> excursions) async {
  List<String> listIdTypes = excursions.map((e) => e.type).toList();
  List<TypeEntity>? types = await GetListType(TypeDataRepository()).call(listIdTypes);
  List<TypeEntity> sortTypes = [];
  if (types != null) {
    for (var id in listIdTypes) {
      for (var type in types) {
        if (type.id == id) sortTypes.add(type);
      }
    }
  }

  List<String> listCodesCurrency = excursions.map((e) => e.currency).toList();
  List<CurrencyEntity>? currencies =
      await GetListCurrency(CurrencyDataRepository()).call(codes: listCodesCurrency);
  List<CurrencyEntity> sortCurrencies = [];
  if (currencies != null) {
    for (var code in listCodesCurrency) {
      for (var currency in currencies) {
        if (currency.code == code) sortCurrencies.add(currency);
      }
    }
  }

  return {
    "types": sortTypes,
    "currencies": sortCurrencies,
  };
}

abstract class ModerateGuideExcursionsAction {}

class LoadModerateGuideExcursionsAction extends ModerateGuideExcursionsAction {}

class ErrorModerateGuideExcursionsAction extends ModerateGuideExcursionsAction {}

class ShowModerateGuideExcursionsAction extends ModerateGuideExcursionsAction {
  final List<ExcursionEntity> excursions;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currency;

  ShowModerateGuideExcursionsAction({
    required this.excursions,
    required this.types,
    required this.currency,
  });
}

ThunkAction ModerateExcursionsThunkAction() => (Store store) async {
      store.dispatch(LoadModerateGuideExcursionsAction);
      List<ExcursionEntity>? responseExcursions =
          await ExcursionDataRepository().getModerateExcursionByGuide(store.state.authState.token);
      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(ShowModerateGuideExcursionsAction(
            excursions: [],
            types: [],
            currency: [],
          ));
        } else {
          Map<String, List> data = await getDataExcursion(responseExcursions);
          if (data["types"]!.length != responseExcursions.length ||
              data["currencies"]!.length != responseExcursions.length) {
            store.dispatch(ErrorModerateGuideExcursionsAction());
          } else {
            store.dispatch(ShowModerateGuideExcursionsAction(
              excursions: responseExcursions,
              types: data["types"] as List<TypeEntity>,
              currency: data["currencies"] as List<CurrencyEntity>,
            ));
          }
        }
      } else {
        store.dispatch(ErrorModerateGuideExcursionsAction());
      }
    };

