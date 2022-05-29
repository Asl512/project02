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

abstract class LoadActivityExcursionsByGuideAction {}

class LoadActivityExcursionsAction extends LoadActivityExcursionsByGuideAction {
}

class ErrorActivityExcursionsAction
    extends LoadActivityExcursionsByGuideAction {}

class ShowActivityExcursionsAction extends LoadActivityExcursionsByGuideAction {
  final List<ExcursionEntity> excursions;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currency;

  ShowActivityExcursionsAction(
      {required this.excursions, required this.types, required this.currency});
}

ThunkAction getActiveExcursionsByGuideThunkAction() => (Store store) async {
      store.dispatch(LoadActivityExcursionsAction);
      List<ExcursionEntity>? responseExcursions;
      ExcursionDataRepository repository = ExcursionDataRepository();
      responseExcursions = await repository
          .getActiveExcursionByGuide(store.state.authState.token);
      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(ShowActivityExcursionsAction(
            excursions: [],
            types: [],
            currency: [],
          ));
        }
        Map<String, List> data = await getDataExcursion(responseExcursions);
        if (data["types"]!.length != responseExcursions.length ||
            data["currencies"]!.length != responseExcursions.length) {
          store.dispatch(ErrorActivityExcursionsAction());
        } else {
          store.dispatch(ShowActivityExcursionsAction(
            excursions: responseExcursions,
            types: data["types"] as List<TypeEntity>,
            currency: data["currencies"] as List<CurrencyEntity>,
          ));
        }
      } else {
        store.dispatch(ErrorActivityExcursionsAction());
      }
    };

Future<Map<String, List>> getDataExcursion(
    List<ExcursionEntity> excursions) async {
  List<String> listIdTypes = excursions.map((e) => e.type).toList();
  List<TypeEntity>? types =
      await GetListType(TypeDataRepository()).call(listIdTypes);
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
      await GetListCurrency(CurrencyDataRepository())
          .call(codes: listCodesCurrency);
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

abstract class LoadModerateExcursionsByGuideAction {}

class LoadModerateExcursionsAction extends LoadModerateExcursionsByGuideAction {
}

class ErrorModerateExcursionsAction
    extends LoadModerateExcursionsByGuideAction {}

class ShowModerateExcursionsAction extends LoadModerateExcursionsByGuideAction {
  final List<ExcursionEntity> excursions;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currency;

  ShowModerateExcursionsAction(
      {required this.excursions, required this.types, required this.currency});
}

ThunkAction getModerateExcursionsByGuideThunkAction() => (Store store) async {
      store.dispatch(LoadModerateExcursionsAction);
      List<ExcursionEntity>? responseExcursions;
      ExcursionDataRepository repository = ExcursionDataRepository();
      responseExcursions = await repository
          .getModerateExcursionByGuide(store.state.authState.token);
      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(ShowModerateExcursionsAction(
            excursions: [],
            types: [],
            currency: [],
          ));
        }
        Map<String, List> data = await getDataExcursion(responseExcursions);
        if (data["types"]!.length != responseExcursions.length ||
            data["currencies"]!.length != responseExcursions.length) {
          store.dispatch(ErrorModerateExcursionsAction());
        } else {
          store.dispatch(ShowModerateExcursionsAction(
            excursions: responseExcursions,
            types: data["types"] as List<TypeEntity>,
            currency: data["currencies"] as List<CurrencyEntity>,
          ));
        }
      } else {
        store.dispatch(ErrorModerateExcursionsAction());
      }
    };
