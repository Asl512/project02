import 'package:lan_code/back-end/data/repositories/excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/photos_excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/review_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/tag_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_move_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/photos_excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/useCases/excursion_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/photos_excursion_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/review_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/tag_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_move_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/user_useCase.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class ListExcursionsAction {}

class LoadListExcursionsAction extends ListExcursionsAction {}

class ErrorListExcursionsAction extends ListExcursionsAction {}

class GetListExcursionsAction extends ListExcursionsAction {
  final List<ExcursionEntity> excursions;
  final List<UserEntity> users;
  final List<TypeEntity> types;

  GetListExcursionsAction({
    required this.excursions,
    required this.users,
    required this.types,
  });
}

ThunkAction GetListExcursionsThunkAction({String? type}) => (Store store) async {
      store.dispatch(LoadListExcursionsAction());
      List<ExcursionEntity>? responseExcursions;

      if (type == null) {
        responseExcursions = await GetAllExcursion(ExcursionDataRepository()).call();
      } else {
        responseExcursions = await GetExcursionByType(ExcursionDataRepository()).call(type);
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

  return {"users": sortUsers, "types": sortTypes};
}

abstract class ExcursionInfoAction {}

class LoadExcursionInfoAction extends ExcursionInfoAction {
  final ExcursionEntity excursion;
  final UserEntity user;
  final TypeEntity type;

  LoadExcursionInfoAction({
    required this.excursion,
    required this.user,
    required this.type,
  });
}

class ErrorExcursionInfoAction extends ExcursionInfoAction {}

class GetExcursionInfoAction extends ExcursionInfoAction {
  final ExcursionEntity excursion;
  final UserEntity user;
  final TypeEntity type;
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
    required this.tags,
  });
}

ThunkAction GetExcursionInfoThunkAction({
  required ExcursionEntity excursion,
  required UserEntity user,
  required TypeEntity type,
}) =>
    (Store store) async {
      store.dispatch(LoadExcursionInfoAction(
        excursion: excursion,
        user: user,
        type: type,
      ));

      PhotosExcursionEntity? responsePhotoExcursion =
          await GetPhotosExcursion(PhotosExcursionDataRepository()).call(idExcursion: excursion.id);

      List<ReviewsEntity>? responseReviews =
          await GetReviews(ReviewDataRepository()).call(idExcursion: excursion.id);

      List<UserEntity> sortUsers = [];
      if(responseReviews != null && responseReviews.isNotEmpty){
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

      List<String> tagsId = excursion.tags.map((e) => e as String).toList();
      List<TagEntity>? responseTags = await GetListTag(TagDataRepository()).call(indexes: tagsId);

      List<String> typesMoveId = excursion.moveType.map((e) => e as String).toList();
      List<TypeMoveEntity>? responseTypeMove =
      await GetListTypeMove(TypeMoveDataRepository()).call(indexes: typesMoveId);

      store.dispatch(GetExcursionInfoAction(
        excursion: excursion,
        user: user,
        type: type,
        photos: responsePhotoExcursion,
        usersReview: sortUsers,
        reviews: responseReviews ?? [],
        tags: responseTags ?? [],
        typesMove: responseTypeMove ?? [],
      ));
    };