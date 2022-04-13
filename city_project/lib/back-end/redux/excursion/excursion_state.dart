import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

part 'excursion_state.freezed.dart';

@freezed
class ListExcursionsState with _$ListExcursionsState {
  const factory ListExcursionsState({
  @Default([]) List<ExcursionEntiti> excursions,
  @Default([]) List<UserEntity> users,
  @Default([]) List<TypeEntity> types,
  @Default(false) bool isError,
  @Default(false) bool isLoading,
  }) = _ListExcursionsState;
}

@freezed
class ExcursionInfoState with _$ExcursionInfoState {
  const factory ExcursionInfoState({
    ExcursionEntiti? excursion,
    @Default(false) bool isError,
    @Default(false) bool isLoading,
  }) = _ExcursionInfoState;
}
