import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_state.freezed.dart';

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
