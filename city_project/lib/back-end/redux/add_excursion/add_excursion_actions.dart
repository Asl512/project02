import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/repositories/city_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/tag_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_move_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/useCases/city_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/tag_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_move_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_useCase.dart';
import 'package:lan_code/service.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class AddExcursionAction {}

class LoadAddExcursionAction extends AddExcursionAction {}

class ErrorAddExcursionAction extends AddExcursionAction {}

class ShowAddExcursionAction extends AddExcursionAction {
  final List<CityEntity> cities;
  final List<TypeEntity> types;
  final List<TagEntity> tags;
  final List<TypeMoveEntity> typesMove;

  ShowAddExcursionAction({
    required this.cities,
    required this.tags,
    required this.types,
    required this.typesMove,
  });
}

ThunkAction AddExcursionThunkAction() => (Store store) async {
      store.dispatch(LoadAddExcursionAction());

      ///проверка на гида

      List<CityEntity>? responseCities = await GetAllCity(CityDataRepository()).call();
      List<TypeEntity>? responseTypes = await GetAllType(TypeDataRepository()).call();
      List<TypeMoveEntity>? responseTypesMove =
          await GetAllTypeMove(TypeMoveDataRepository()).call();
      List<TagEntity>? responseTags = await GetAllTag(TagDataRepository()).call();

      if (responseCities != null ||
          responseTags != null ||
          responseTypes != null ||
          responseTypesMove != null) {
        store.dispatch(
          ShowAddExcursionAction(
            tags: responseTags!,
            cities: responseCities!,
            types: responseTypes!,
            typesMove: responseTypesMove!,
          ),
        );
      } else {
        store.dispatch(ErrorAddExcursionAction());
      }
    };

abstract class InsertExcursionAction {}

class LoadInsetExcursionAction extends InsertExcursionAction {}

class InsertedExcursionAction extends InsertExcursionAction {}

class ErrorInsetExcursionAction extends InsertExcursionAction {
  final bool? isError;
  final List? errorName;
  final List? errorCity;
  final List? errorGroupSize;
  final List? errorDuration;
  final List? errorMeetPoint;
  final List? errorStandardPrice;
  final List? errorTypesMove;

  ErrorInsetExcursionAction({
    this.isError,
    this.errorName,
    this.errorCity,
    this.errorGroupSize,
    this.errorDuration,
    this.errorMeetPoint,
    this.errorStandardPrice,
    this.errorTypesMove,
  });
}

ThunkAction InsertThunkAction({
  required CityEntity? city,
  required String idGuide,
}) =>
    (Store store) async {
      store.dispatch(LoadInsetExcursionAction());
      await FirebaseFirestore.instance.collection('excursion').add({
        "name": 'Экскурсия по трубам',
        "photo": "null",
        "organizationalDetails": "null",
        "addServices": "null",
        "included": "null",
        "tags": [],
        "duration": "1 час",
        "description": "null",
        "idGuide": idGuide,
        "type": "3",
        "moment": false,
        "moveType": [],
        "meetPoint": "Труба",
        "rating": [0,1],
        "groupSize": 10,
        "standartPrice": 1000,
        "idCity": city!.id,
      });
      print('Adddddddddddddddddd');
      store.dispatch(InsertedExcursionAction());
    };
