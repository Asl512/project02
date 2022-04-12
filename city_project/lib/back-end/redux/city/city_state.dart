import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';

part 'city_state.freezed.dart';

@freezed
class ListCitiesState with _$ListCitiesState {
  const factory ListCitiesState({
    @Default(false) bool isError,
    @Default(false) bool isLoading,
    @Default([]) List<CityEntiti> cities,
  }) = _ListCitiesState;
}

@freezed
class CityState with _$CityState {
  const factory CityState({
    @Default(false) bool isError,
    @Default(false) bool isLoading,
    CityEntiti? city,
  }) = _CityState;
}
