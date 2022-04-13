import 'package:lan_code/back-end/data/repositories/excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/useCases/excursion_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/user_useCase.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class ListExcursionsAction {}

class LoadListExcursionsAction extends ListExcursionsAction {}

class ErrorListExcursionsAction extends ListExcursionsAction {}

class GetListExcursionsAction extends ListExcursionsAction {
  final List<ExcursionEntiti> excursions;
  final List<UserEntity> users;
  final List<TypeEntity> types;

  GetListExcursionsAction({
    required this.excursions,
    required this.users,
    required this.types,
  });
}

ThunkAction GetListExcursionsThunkAction({String? type}) =>
    (Store store) async {
      store.dispatch(LoadListExcursionsAction());
      List<ExcursionEntiti>? responseExcursions;

      if (type == null) {
        responseExcursions =
            await GetAllExcursion(ExcursionDataRepository()).call();
      } else {
        responseExcursions =
            await GetExcursionByType(ExcursionDataRepository()).call(type);
      }

      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(GetListExcursionsAction(
            excursions: [],
            users: [],
            types: [],
          ));
        }
        Map<String, List> data = await getDataExcursion(responseExcursions);
        if (data["users"]!.length != responseExcursions.length ||
            data["types"]!.length != responseExcursions.length) {
          store.dispatch(ErrorListExcursionsAction());
        } else {
          store.dispatch(GetListExcursionsAction(
            excursions: responseExcursions,
            users: data["users"] as List<UserEntity>,
            types: data["types"] as List<TypeEntity>,
          ));
        }
      } else {
        store.dispatch(ErrorListExcursionsAction());
      }
    };

Future<Map<String, List>> getDataExcursion(
    List<ExcursionEntiti> excursions) async {
  List<String> listIdUsers = excursions.map((e) => e.guide).toList();
  List<UserEntity>? users =
      await GetListUsers(UserDataRepository()).call(listIdUsers);
  List<UserEntity> sortUsers = [];
  if (users != null) {
    for (var id in listIdUsers) {
      for (var user in users) {
        if (user.id == id) sortUsers.add(user);
      }
    }
  }

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

  return {"users": sortUsers, "types": sortTypes};
}

abstract class ExcursionInfoAction {}

class LoadExcursionInfoAction extends ExcursionInfoAction {}

class ErrorExcursionInfoAction extends ExcursionInfoAction {}

class GetExcursionInfoAction extends ExcursionInfoAction {
  final ExcursionEntiti excursion;

  GetExcursionInfoAction({
    required this.excursion,
  });
}

ThunkAction GetExcursionInfoThunkAction({required ExcursionEntiti excursion}) =>
    (Store store) async {
      store.dispatch(LoadExcursionInfoAction());
      store.dispatch(GetExcursionInfoAction(excursion: excursion));
    };
