import 'package:lan_code/back-end/redux/booking/booking_action.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:redux/redux.dart';

Reducer<BookingInfoState> bookingInfoReducer = combineReducers([
  TypedReducer<BookingInfoState, LoadBookingInfoAction>(_loadBookingInfo),
  TypedReducer<BookingInfoState, ErrorBookingInfoAction>(_errorBookingInfo),
  TypedReducer<BookingInfoState, ShowBookingInfoAction>(_showBookingInfo),
  TypedReducer<BookingInfoState, NotAuthBookingInfoAction>(_notAuthBookingInfo),
]);

Reducer<BookingState> bookingReducer = combineReducers([
  TypedReducer<BookingState, LoadBookingAction>(_loadBooking),
  TypedReducer<BookingState, ErrorBookingAction>(_errorBooking),
]);

BookingInfoState _loadBookingInfo(
  BookingInfoState state,
  LoadBookingInfoAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
      isAuth: true,
    );

BookingInfoState _errorBookingInfo(
  BookingInfoState state,
  ErrorBookingInfoAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      isAuth: true,
    );

BookingInfoState _notAuthBookingInfo(
    BookingInfoState state,
    NotAuthBookingInfoAction action,
    ) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      isAuth: false,
    );

BookingInfoState _showBookingInfo(
  BookingInfoState state,
  ShowBookingInfoAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      isAuth: true,
      categoriesPeople: action.categoriesPeople,
    );

BookingState _loadBooking(
  BookingState state,
  LoadBookingAction action,
) =>
    state.copyWith(
      isLoading: true,
    );

BookingState _errorBooking(
  BookingState state,
  ErrorBookingAction action,
) =>
    state.copyWith(
      isLoading: false,
      errorPhone: action.errorPhone ?? [false, ''],
      errorCountTickets: action.errorCountTickets ?? [false, ''],
      errorDate: action.errorDate ?? [false, ''],
    );
