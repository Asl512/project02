import 'package:lan_code/back-end/data/repositories/currency_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/photos_excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/review_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/tag_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_move_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/photos_excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/useCases/currency_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/excursion_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/photos_excursion_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/review_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/tag_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_move_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/user_useCase.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class AllExcursionsAction {}

class LoadAllExcursionsAction extends AllExcursionsAction {}

class ErrorAllExcursionsAction extends AllExcursionsAction {}

class GetAllExcursionsAction extends AllExcursionsAction {
  final List<ExcursionEntity> excursions;
  final List<UserEntity> users;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currencies;

  GetAllExcursionsAction({
    required this.excursions,
    required this.users,
    required this.types,
    required this.currencies,
  });
}

ThunkAction GetAllExcursionsThunkAction() => (Store store) async {
      store.dispatch(LoadAllExcursionsAction());
      List<ExcursionEntity>? responseExcursions;

      responseExcursions = await GetAllExcursion(ExcursionDataRepository()).call();

      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(GetAllExcursionsAction(
            excursions: [],
            users: [],
            types: [],
            currencies: [],
          ));
        }
        Map<String, List> data = await getDataExcursion(responseExcursions);
        if (data["users"]!.length != responseExcursions.length ||
            data["types"]!.length != responseExcursions.length ||
            data["currencies"]!.length != responseExcursions.length) {
          store.dispatch(ErrorAllExcursionsAction());
        } else {
          store.dispatch(GetAllExcursionsAction(
            excursions: responseExcursions,
            users: data["users"] as List<UserEntity>,
            types: data["types"] as List<TypeEntity>,
            currencies: data["currencies"] as List<CurrencyEntity>,
          ));
        }
      } else {
        store.dispatch(ErrorAllExcursionsAction());
      }
    };

abstract class GroupExcursionsAction {}

class LoadGroupExcursionsAction extends GroupExcursionsAction {}

class ErrorGroupExcursionsAction extends GroupExcursionsAction {}

class GetGroupExcursionsAction extends GroupExcursionsAction {
  final List<ExcursionEntity> excursions;
  final List<UserEntity> users;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currencies;

  GetGroupExcursionsAction({
    required this.excursions,
    required this.users,
    required this.types,
    required this.currencies,
  });
}

ThunkAction GetGroupExcursionsThunkAction() => (Store store) async {
      store.dispatch(LoadGroupExcursionsAction());
      List<ExcursionEntity>? responseExcursions;

      responseExcursions = await GetExcursionByType(ExcursionDataRepository()).call('12');

      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(GetGroupExcursionsAction(
            excursions: [],
            users: [],
            types: [],
            currencies: [],
          ));
        }
        Map<String, List> data = await getDataExcursion(responseExcursions);
        if (data["users"]!.length != responseExcursions.length ||
            data["types"]!.length != responseExcursions.length ||
            data["currencies"]!.length != responseExcursions.length) {
          store.dispatch(ErrorGroupExcursionsAction());
        } else {
          store.dispatch(GetGroupExcursionsAction(
            excursions: responseExcursions,
            users: data["users"] as List<UserEntity>,
            types: data["types"] as List<TypeEntity>,
            currencies: data["currencies"] as List<CurrencyEntity>,
          ));
        }
      } else {
        store.dispatch(ErrorGroupExcursionsAction());
      }
    };

abstract class IndividualExcursionsAction {}

class LoadIndividualExcursionsAction extends IndividualExcursionsAction {}

class ErrorIndividualExcursionsAction extends IndividualExcursionsAction {}

class GetIndividualExcursionsAction extends IndividualExcursionsAction {
  final List<ExcursionEntity> excursions;
  final List<UserEntity> users;
  final List<TypeEntity> types;
  final List<CurrencyEntity> currencies;

  GetIndividualExcursionsAction({
    required this.excursions,
    required this.users,
    required this.types,
    required this.currencies,
  });
}

ThunkAction GetIndividualExcursionsThunkAction() => (Store store) async {
      store.dispatch(LoadIndividualExcursionsAction());
      List<ExcursionEntity>? responseExcursions;

      responseExcursions = await GetExcursionByType(ExcursionDataRepository()).call('3');

      if (responseExcursions != null) {
        if (responseExcursions.isEmpty) {
          store.dispatch(GetIndividualExcursionsAction(
            excursions: [],
            users: [],
            types: [],
            currencies: [],
          ));
        }
        Map<String, List> data = await getDataExcursion(responseExcursions);
        if (data["users"]!.length != responseExcursions.length ||
            data["types"]!.length != responseExcursions.length ||
            data["currencies"]!.length != responseExcursions.length) {
          store.dispatch(ErrorIndividualExcursionsAction());
        } else {
          store.dispatch(GetIndividualExcursionsAction(
            excursions: responseExcursions,
            users: data["users"] as List<UserEntity>,
            types: data["types"] as List<TypeEntity>,
            currencies: data["currencies"] as List<CurrencyEntity>,
          ));
        }
      } else {
        store.dispatch(ErrorIndividualExcursionsAction());
      }
    };

Future<Map<String, List>> getDataExcursion(List<ExcursionEntity> excursions) async {
  List<String> listIdUsers = excursions.map((e) => e.guide).toList();
  List<UserEntity>? users = await GetListUsers(UserDataRepository()).call(listIdUsers);
  List<UserEntity> sortUsers = [];
  if (users != null) {
    for (var id in listIdUsers) {
      for (var user in users) {
        if (user.id == id) sortUsers.add(user);
      }
    }
  }

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
    "users": sortUsers,
    "types": sortTypes,
    "currencies": sortCurrencies,
  };
}

abstract class ExcursionInfoAction {}

class LoadExcursionInfoAction extends ExcursionInfoAction {
  final ExcursionEntity excursion;
  final UserEntity user;
  final TypeEntity type;
  final CurrencyEntity currency;

  LoadExcursionInfoAction({
    required this.excursion,
    required this.user,
    required this.type,
    required this.currency,
  });
}

class ErrorExcursionInfoAction extends ExcursionInfoAction {}

class GetExcursionInfoAction extends ExcursionInfoAction {
  final ExcursionEntity excursion;
  final UserEntity user;
  final TypeEntity type;
  final CurrencyEntity currency;
  final PhotosExcursionEntity? photos;
  final List<ReviewsEntity>? reviews;
  final List<UserEntity>? usersReview;
  final List<TagEntity> tags;
  final List<TypeMoveEntity> typesMove;

  GetExcursionInfoAction({
    required this.excursion,
    required this.user,
    required this.type,
    required this.photos,
    required this.typesMove,
    required this.usersReview,
    required this.reviews,
    required this.currency,
    required this.tags,
  });
}

ThunkAction GetExcursionInfoThunkAction({
  required ExcursionEntity excursion,
  required UserEntity user,
  required TypeEntity type,
  required CurrencyEntity currency,
}) =>
    (Store store) async {
      store.dispatch(LoadExcursionInfoAction(
        currency: currency,
        excursion: excursion,
        user: user,
        type: type,
      ));

      PhotosExcursionEntity? responsePhotoExcursion =
          await GetPhotosExcursion(PhotosExcursionDataRepository()).call(idExcursion: excursion.id);

      List<ReviewsEntity>? responseReviews =
          await GetReviews(ReviewDataRepository()).call(idExcursion: excursion.id);

      List<UserEntity> sortUsers = [];
      if (responseReviews != null && responseReviews.isNotEmpty) {
        List<String> userId = responseReviews.map((review) => review.user).toList();
        List<UserEntity>? users = await GetListUsers(UserDataRepository()).call(userId);
        if (users != null) {
          for (var id in userId) {
            for (var user in users) {
              if (user.id == id) sortUsers.add(user);
            }
          }
        }
      }

      List<TagEntity>? responseTags;
      List<String> tagsId = excursion.tags.map((e) => e as String).toList();
      if (tagsId.isNotEmpty) {
        responseTags = await GetListTag(TagDataRepository()).call(indexes: tagsId);
      }

      List<TypeMoveEntity>? responseTypeMove;
      List<String> typesMoveId = excursion.moveType.map((e) => e as String).toList();
      if (typesMoveId.isNotEmpty) {
        responseTypeMove =
            await GetListTypeMove(TypeMoveDataRepository()).call(indexes: typesMoveId);
      }

      store.dispatch(GetExcursionInfoAction(
        excursion: excursion,
        user: user,
        type: type,
        currency: currency,
        photos: responsePhotoExcursion,
        usersReview: sortUsers,
        reviews: responseReviews ?? [],
        tags: responseTags ?? [],
        typesMove: responseTypeMove ?? [],
      ));
    };
