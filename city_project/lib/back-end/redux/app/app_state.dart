import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/redux/user/user_state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required ListCitiesState listCitiesState,
    required CityState cityState,
    required ListExcursionsState listExcursionsState,
    required ExcursionInfoState excursionInfoState,
    required AuthState authState,
    required AddExcursionState addExcursionState,
    required InsertExcursionState insertExcursionState,
    required BookingState bookingState,
  }) = _AppState;
}
