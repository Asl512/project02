import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:redux/redux.dart';

Reducer<AddExcursionState> addExcursionReducer = combineReducers([
  TypedReducer<AddExcursionState, LoadAddExcursionAction>(_loadAddExcursion),
  TypedReducer<AddExcursionState, ErrorAddExcursionAction>(_errorAddExcursion),
  TypedReducer<AddExcursionState, ShowAddExcursionAction>(_showAddExcursion),
]);

Reducer<InsertExcursionState> insertExcursionReducer = combineReducers([
  TypedReducer<InsertExcursionState, LoadInsetExcursionAction>(_loadInsertExcursion),
  TypedReducer<InsertExcursionState, ErrorInsetExcursionAction>(_errorInsertExcursion),
  TypedReducer<InsertExcursionState, ChangeTypeInsetExcursionAction>(_changeTypeInsertExcursion),
  TypedReducer<InsertExcursionState, ChangeCurrencyInsetExcursionAction>(
    _changeCurrencyInsertExcursion,
  ),
]);

//load page

AddExcursionState _loadAddExcursion(
  AddExcursionState state,
  LoadAddExcursionAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

AddExcursionState _errorAddExcursion(
  AddExcursionState state,
  ErrorAddExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

AddExcursionState _showAddExcursion(
  AddExcursionState state,
  ShowAddExcursionAction action,
) =>
    state.copyWith(
      cities: action.cities,
      tags: action.tags,
      types: action.types,
      typesMove: action.typesMove,
      currencies: action.currencies,
      categoriesPeople: action.categoriesPeople,
      isLoading: false,
      isError: false,
    );

//insert excursion

InsertExcursionState _loadInsertExcursion(
  InsertExcursionState state,
  LoadInsetExcursionAction action,
) =>
    state.copyWith(
      isLoading: true,
    );

InsertExcursionState _changeTypeInsertExcursion(
  InsertExcursionState state,
  ChangeTypeInsetExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      type: action.type,
    );

InsertExcursionState _changeCurrencyInsertExcursion(
  InsertExcursionState state,
  ChangeCurrencyInsetExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      currency: action.currency,
    );

InsertExcursionState _errorInsertExcursion(
  InsertExcursionState state,
  ErrorInsetExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      errorName: action.errorName ?? [false, 'errorName'],
      errorGroupSize: action.errorGroupSize ?? [false, 'errorGroupSize'],
      errorDuration: action.errorDuration ?? [false, 'errorDuration'],
      errorCity: action.errorCity ?? [false, 'errorCity'],
      errorMeetPoint: action.errorMeetPoint ?? [false, 'errorMeetPoint'],
      errorStandardPrice: action.errorStandardPrice ?? [false, 'errorStandardPrice'],
      errorTypesMove: action.errorTypesMove ?? [false, 'errorTypesMove'],
      errorDescription: action.errorDescription ?? [false, 'errorDescription'],
      errorDate: action.errorDate ?? [false, 'errorDate'],
    );
