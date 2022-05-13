import 'package:lan_code/back-end/redux/booking/booking_action.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:redux/redux.dart';

Reducer<BookingState> bookingReducer = combineReducers([
  TypedReducer<BookingState, LoadBookingAction>(_loadInsertExcursion),
  TypedReducer<BookingState, ErrorBookingAction>(_errorInsertExcursion),
]);

BookingState _loadInsertExcursion(
  BookingState state,
  LoadBookingAction action,
) =>
    state.copyWith(
      isLoading: true,
    );

BookingState _errorInsertExcursion(
  BookingState state,
  ErrorBookingAction action,
) =>
    state.copyWith(
      isLoading: false,
      errorPhone: action.errorPhone ?? [false, ''],
      errorCountTickets: action.errorCountTickets ?? [false, ''],
      errorDate: action.errorDate ?? [false, ''],
    );
