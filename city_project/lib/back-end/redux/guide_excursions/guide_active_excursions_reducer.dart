import 'package:lan_code/back-end/redux/guide_excursions/guide_active_excursions_action.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:redux/redux.dart';

Reducer<ListExcursionsState> activeGuideExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadActivityGuideExcursionsAction>(_loadActive),
  TypedReducer<ListExcursionsState, ErrorActivityGuideExcursionsAction>(_errorActive),
  TypedReducer<ListExcursionsState, ShowActivityGuideExcursionsAction>(_showActive),
]);

Reducer<ListExcursionsState> moderateGuideExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadModerateGuideExcursionsAction>(_loadModerate),
  TypedReducer<ListExcursionsState, ErrorModerateGuideExcursionsAction>(_errorModerate),
  TypedReducer<ListExcursionsState, ShowModerateGuideExcursionsAction>(_showModerate),
]);

//List excursions

ListExcursionsState _loadActive(
  ListExcursionsState state,
  LoadActivityGuideExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorActive(
  ListExcursionsState state,
  ErrorActivityGuideExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _showActive(
  ListExcursionsState state,
  ShowActivityGuideExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currency,
      types: action.types,
      isLoading: false,
      isError: false,
    );

ListExcursionsState _loadModerate(
  ListExcursionsState state,
  LoadModerateGuideExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorModerate(
  ListExcursionsState state,
  ErrorModerateGuideExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _showModerate(
  ListExcursionsState state,
  ShowModerateGuideExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currency,
      types: action.types,
      isLoading: false,
      isError: false,
    );
