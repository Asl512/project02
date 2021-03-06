import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

part 'excursion_state.freezed.dart';

@freezed
class ListExcursionsState with _$ListExcursionsState {
  const factory ListExcursionsState({
    @Default([]) List<ExcursionEntity> excursions,
    @Default([]) List<UserEntity> users,
    @Default([]) List<TypeEntity> types,
    @Default([]) List<CurrencyEntity> currencies,
    @Default(false) bool isError,
    @Default(false) bool isLoading,
  }) = _ListExcursionsState;
}

@freezed
class ExcursionInfoState with _$ExcursionInfoState {
  const factory ExcursionInfoState({
    ExcursionEntity? excursion,
    UserEntity? user,
    TypeEntity? type,
    CurrencyEntity? currency,
    List<ReviewsEntity>? reviews,
    List<UserEntity>? userReview,
    @Default([]) List<TagEntity> tags,
    @Default([]) List<TypeMoveEntity> typesMove,
    @Default(false) bool isError,
    @Default(false) bool isLoading,
  }) = _ExcursionInfoState;
}
