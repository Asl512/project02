import 'package:lan_code/back-end/redux/ticket/ticket_actions.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_state.dart';
import 'package:redux/redux.dart';

Reducer<TicketListState> ticketListActivityReducer = combineReducers([
  TypedReducer<TicketListState, LoadTicketListActivityAction>(_loadActive),
  TypedReducer<TicketListState, ErrorTicketListActivityAction>(_errorActive),
  TypedReducer<TicketListState, ShowTicketListActivityAction>(_showActive),
]);

Reducer<TicketListState> ticketListCancelReducer = combineReducers([
  TypedReducer<TicketListState, LoadTicketListCancelAction>(_loadCancel),
  TypedReducer<TicketListState, ErrorTicketListCancelAction>(_errorCancel),
  TypedReducer<TicketListState, ShowTicketListCancelAction>(_showCancel),
]);

Reducer<TicketDetailState> ticketDetailReducer = combineReducers([
  TypedReducer<TicketDetailState, LoadTicketDetailAction>(_loadDetail),
  TypedReducer<TicketDetailState, ErrorTicketDetailAction>(_errorDetail),
  TypedReducer<TicketDetailState, ShowTicketDetailAction>(_showDetail),
]);

//Detail

TicketDetailState _loadDetail(
  TicketDetailState state,
  LoadTicketDetailAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

TicketDetailState _errorDetail(
  TicketDetailState state,
  ErrorTicketDetailAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

TicketDetailState _showDetail(
  TicketDetailState state,
  ShowTicketDetailAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      guide: action.guide,
      typesMove: action.typesMove,
      categoryPeople: action.categoryPeople,
    );

//Cancel

TicketListState _loadCancel(
  TicketListState state,
  LoadTicketListCancelAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

TicketListState _errorCancel(
  TicketListState state,
  ErrorTicketListCancelAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

TicketListState _showCancel(
  TicketListState state,
  ShowTicketListCancelAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      excursions: action.excursions,
      tickets: action.tickets,
    );

//Active

TicketListState _loadActive(
  TicketListState state,
  LoadTicketListActivityAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

TicketListState _errorActive(
  TicketListState state,
  ErrorTicketListActivityAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

TicketListState _showActive(
  TicketListState state,
  ShowTicketListActivityAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      excursions: action.excursions,
      tickets: action.tickets,
    );
