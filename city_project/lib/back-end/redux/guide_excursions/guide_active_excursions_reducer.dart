import 'package:lan_code/back-end/redux/guide_excursions/guide_active_excursions_action.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:redux/redux.dart';

Reducer<ListExcursionsState> listActiveGuideExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadActivityExcursionsAction>(_loadActiveExcursions),
  TypedReducer<ListExcursionsState, ErrorActivityExcursionsAction>(_errorActiveExcursions),
  TypedReducer<ListExcursionsState, ShowActivityExcursionsAction>(_showActiveExcursions),
]);

Reducer<ListExcursionsState> listModerateGuideExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadModerateExcursionsAction>(_loadModerateExcursions),
  TypedReducer<ListExcursionsState, ErrorModerateExcursionsAction>(_errorModerateExcursions),
  TypedReducer<ListExcursionsState, ShowModerateExcursionsAction>(_showModerateExcursions),
]);


//List excursions

ListExcursionsState _loadActiveExcursions(
  ListExcursionsState state,
  LoadActivityExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorActiveExcursions(
  ListExcursionsState state,
  ErrorActivityExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _showActiveExcursions(
  ListExcursionsState state,
  ShowActivityExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currency,
      types: action.types,
      isLoading: false,
      isError: false,
    );

ListExcursionsState _loadModerateExcursions(
  ListExcursionsState state,
  LoadModerateExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorModerateExcursions(
  ListExcursionsState state,
  ErrorModerateExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _showModerateExcursions(
  ListExcursionsState state,
  ShowModerateExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currency,
      types: action.types,
      isLoading: false,
      isError: false,
    );