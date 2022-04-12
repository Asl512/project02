import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required ListCitiesState listCitiesState,
    required CityState cityState,
    required ListExcursionsState listExcursionsState,
  }) = _AppState;
}
