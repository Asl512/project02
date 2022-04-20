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
  TypedReducer<InsertExcursionState, InsertedExcursionAction>(_insertedExcursion),
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
      isError: false,
    );

InsertExcursionState _errorInsertExcursion(
  InsertExcursionState state,
  ErrorInsetExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: action.isError ?? false,
      errorCity: (action.errorCity?.first) ?? false,
      errorDuration: (action.errorDuration?.first) ?? false,
      errorGroupSize: (action.errorGroupSize?.first) ?? false,
      errorName: (action.errorName?.first) ?? false,
      errorMeetPoint: (action.errorMeetPoint?.first) ?? false,
      errorStandardPrice: (action.errorStandardPrice?.first) ?? false,
      errorTypesMove: (action.errorTypesMove?.first) ?? false,
    );

InsertExcursionState _insertedExcursion(
  InsertExcursionState state,
  InsertedExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
    );
