import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingInfoState with _$BookingInfoState {
  const factory BookingInfoState({
    @Default(false) bool isError,
    @Default(false) bool isLoading,
    @Default([]) List<CategoryPeopleEntity> categoriesPeople,
  }) = _BookingInfoState;
}

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    @Default(false) bool isLoading,
    @Default([false, 'errorCountTickets']) List errorCountTickets,
    @Default([false, 'errorPhone']) List errorPhone,
    @Default([false, 'errorDate']) List errorDate,
    @Default(0) int price,
  }) = _BookingState;
}
