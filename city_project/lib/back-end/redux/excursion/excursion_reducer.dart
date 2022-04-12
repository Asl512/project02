import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:redux/redux.dart';

Reducer<ListExcursionsState> listExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadListExcursionsAction>(_loadListExcursions),
  TypedReducer<ListExcursionsState, ErrorListExcursionsAction>(_errorListExcursions),
  TypedReducer<ListExcursionsState, GetListExcursionsAction>(_getListExcursions),
]);

//List cities

ListExcursionsState _loadListExcursions(
  ListExcursionsState state,
  LoadListExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorListExcursions(
  ListExcursionsState state,
  ErrorListExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _getListExcursions(
  ListExcursionsState state,
  GetListExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      users: action.users,
      types: action.types,
      isLoading: false,
      isError: false,
    );
