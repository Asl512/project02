import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingInfoState with _$BookingInfoState {
  const factory BookingInfoState({
    @Default(false) bool isError,
    @Default(false) bool isLoading,
    @Default(false) bool isAuth,
    @Default([]) List<CategoryPeopleEntity> categoriesPeople,
    ExcursionEntity? excursion,
  }) = _BookingInfoState;
}

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    @Default(false) bool isLoading,
    @Default([false, 'errorCountTickets']) List errorCountTickets,
    @Default([false, 'errorPhone']) List errorPhone,
    @Default([false, 'errorDate']) List errorDate,
    @Default([false, 'errorDateForIndividual']) List errorDateForIndividual,
    @Default([false, 'errorTimeForIndividual']) List errorTimeForIndividual,
    @Default([false, 'errorMeetPoint']) List errorMeetPoint,
  }) = _BookingState;
}
