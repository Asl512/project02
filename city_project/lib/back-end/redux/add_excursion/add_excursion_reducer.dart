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
  TypedReducer<InsertExcursionState, ShowErrorInsertExcursionAction>(_showErrorInsertExcursion),
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

InsertExcursionState _showErrorInsertExcursion(
    InsertExcursionState state,
    ShowErrorInsertExcursionAction action,
    ) 
{
print('+++0');
return state.copyWith(
isLoading: false,
isError: true,
);}

InsertExcursionState _errorInsertExcursion(
  InsertExcursionState state,
  ErrorInsetExcursionAction action,
) {
  print('+++0');
  return state.copyWith(
    isLoading: false,
    isError: action.isError ?? false,
    errorCity: action.errorCity ?? [],
    errorDuration: action.errorDuration ?? [],
    errorGroupSize: action.errorGroupSize ?? [],
    errorName: action.errorName ?? [],
    errorMeetPoint: action.errorMeetPoint ?? [],
    errorStandardPrice: action.errorStandardPrice ?? [],
    errorTypesMove: action.errorTypesMove ?? [],
  );
}

InsertExcursionState _insertedExcursion(
  InsertExcursionState state,
  InsertedExcursionAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
    );
