import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
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
    @Default([]) List<CurrencyEntity> currencies,
    @Default([]) List<CategoryPeopleEntity> categoriesPeople,
  }) = _AddExcursionState;
}

@freezed
class InsertExcursionState with _$InsertExcursionState {
  const factory InsertExcursionState({
    @Default(false) bool isLoading,
    TypeEntity? type,
    CurrencyEntity? currency,
    @Default([false, 'errorName']) List errorName,
    @Default([false, 'errorCity']) List errorCity,
    @Default([false, 'errorGroupSize']) List errorGroupSize,
    @Default([false, 'errorDuration']) List errorDuration,
    @Default([false, 'errorDescription']) List errorDescription,
    @Default([false, 'errorMeetPoint']) List errorMeetPoint,
    @Default([false, 'errorStandardPrice']) List errorStandardPrice,
    @Default([false, 'errorTypesMove']) List errorTypesMove,
  }) = _InsertExcursionState;
}
