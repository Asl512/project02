import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_reducer.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_action.dart';
import 'package:lan_code/back-end/redux/booking/booking_reducer.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_reducer.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_reducer.dart';
import 'package:lan_code/back-end/redux/record/actions.dart';
import 'package:lan_code/back-end/redux/record/reducer.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_actions.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_reducer.dart';
import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:lan_code/back-end/redux/user/user_reducer.dart';

import '../guide_excursions/guide_active_excursions_action.dart';
import '../guide_excursions/guide_active_excursions_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ListCitiesAction) {
    final nextState = listCitiesReducer(state.listCitiesState, action);
    return state.copyWith(listCitiesState: nextState);
  } else if (action is CityAction) {
    final nextState = cityReducer(state.cityState, action);
    return state.copyWith(cityState: nextState);
  } else if (action is CityAction) {
    final nextState = cityReducer(state.cityState, action);
    return state.copyWith(cityState: nextState);
  } else if (action is AllExcursionsAction) {
    final nextState = allExcursionsReducer(state.allExcursions, action);
    return state.copyWith(allExcursions: nextState);
  } else if (action is GroupExcursionsAction) {
    final nextState = groupExcursionsReducer(state.groupExcursions, action);
    return state.copyWith(groupExcursions: nextState);
  } else if (action is IndividualExcursionsAction) {
    final nextState = individualExcursionsReducer(state.individualExcursions, action);
    return state.copyWith(individualExcursions: nextState);
  } else if (action is ExcursionInfoAction) {
    final nextState = excursionInfoReducer(state.excursionInfoState, action);
    return state.copyWith(excursionInfoState: nextState);
  } else if (action is AuthAction) {
    final nextState = authReducer(state.authState, action);
    return state.copyWith(authState: nextState);
  } else if (action is AddExcursionAction) {
    final nextState = addExcursionReducer(state.addExcursionState, action);
    return state.copyWith(addExcursionState: nextState);
  } else if (action is InsertExcursionAction) {
    final nextState = insertExcursionReducer(state.insertExcursionState, action);
    return state.copyWith(insertExcursionState: nextState);
  } else if (action is BookingAction) {
    final nextState = bookingReducer(state.bookingState, action);
    return state.copyWith(bookingState: nextState);
  } else if (action is BookingInfoAction) {
    final nextState = bookingInfoReducer(state.bookingInfoState, action);
    return state.copyWith(bookingInfoState: nextState);
  } else if (action is ActivityGuideExcursionsAction) {
    final nextState = activeGuideExcursionsReducer(state.guidActiveExcursions, action);
    return state.copyWith(guidActiveExcursions: nextState);
  } else if (action is ModerateGuideExcursionsAction) {
    final nextState = moderateGuideExcursionsReducer(state.guidModerateExcursions, action);
    return state.copyWith(guidModerateExcursions: nextState);
  } else if (action is TicketListActivityAction) {
    final nextState = ticketListActivityReducer(state.ticketListActivityState, action);
    return state.copyWith(ticketListActivityState: nextState);
  } else if (action is TicketListCancelAction) {
    final nextState = ticketListCancelReducer(state.ticketListCancelState, action);
    return state.copyWith(ticketListCancelState: nextState);
  } else if (action is TicketDetailAction) {
    final nextState = ticketDetailReducer(state.ticketDetailState, action);
    return state.copyWith(ticketDetailState: nextState);
  } else if (action is RecordListAction) {
    final nextState = recordListReducer(state.recordListState, action);
    return state.copyWith(recordListState: nextState);
  }

  return state;
}
