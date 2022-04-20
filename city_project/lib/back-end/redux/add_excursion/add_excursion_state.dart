import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';

part 'add_excursion_state.freezed.dart';

@freezed
class AddExcursionState with _$AddExcursionState {
  const factory AddExcursionState({
    @Default(false) bool isError,
    @Default(false) bool isLoading,
    @Default([]) List<CityEntity> cities,
    @Default([]) List<TypeEntity> types,
    @Default([]) List<TagEntity> tags,
    @Default([]) List<TypeMoveEntity> typesMove,
  }) = _AddExcursionState;
}

@freezed
class InsertExcursionState with _$InsertExcursionState {
  const factory InsertExcursionState({
    @Default(false) bool isError,
    @Default([false, 'errorName']) List errorName,
    @Default([false, 'errorCity']) List errorCity,
    @Default([false, 'errorGroupSize']) List errorGroupSize,
    @Default([false, 'errorDuration']) List errorDuration,
    @Default([false, 'errorMeetPoint']) List errorMeetPoint,
    @Default([false, 'errorStandardPrice']) List errorStandardPrice,
    @Default([false, 'errorTypesMove']) List errorTypesMove,
    @Default(false) bool isLoading,
    CityEntity? city,
    TypeEntity? type,
    @Default('') String name,
    @Default('null') String description,
    @Default('null') String photo,
    @Default(0) int groupSize,
    @Default('') String guide,
    @Default(false) bool moment,
    @Default('') String duration,
    @Default(0.0) double rating,
    @Default('') String meetPoint,
    @Default(0) int standardPrice,
    @Default('null') String addServices,
    @Default('null') String included,
    @Default('null') String organizationalDetails,
    @Default([]) List<TagEntity> tags,
    @Default([]) List<TypeMoveEntity> typesMove,
  }) = _InsertExcursionState;
}
