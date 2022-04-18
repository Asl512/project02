import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:redux/redux.dart';

Reducer<ListExcursionsState> listExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadListExcursionsAction>(_loadListExcursions),
  TypedReducer<ListExcursionsState, ErrorListExcursionsAction>(_errorListExcursions),
  TypedReducer<ListExcursionsState, GetListExcursionsAction>(_getListExcursions),
]);

Reducer<ExcursionInfoState> excursionInfoReducer = combineReducers([
  TypedReducer<ExcursionInfoState, LoadExcursionInfoAction>(_loadExcursionInfo),
  TypedReducer<ExcursionInfoState, ErrorExcursionInfoAction>(_errorExcursionInfo),
  TypedReducer<ExcursionInfoState, GetExcursionInfoAction>(_getExcursionInfo),
]);

//List excursions

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

//Excursion Info

ExcursionInfoState _loadExcursionInfo(
    ExcursionInfoState state,
    LoadExcursionInfoAction action,
    ) =>
    state.copyWith(
      excursion: action.excursion,
      user: action.user,
      type: action.type,
      isLoading: true,
      isError: false,
    );

ExcursionInfoState _errorExcursionInfo(
    ExcursionInfoState state,
    ErrorExcursionInfoAction action,
    ) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ExcursionInfoState _getExcursionInfo(
    ExcursionInfoState state,
    GetExcursionInfoAction action,
    ) =>
    state.copyWith(
      excursion: action.excursion,
      user: action.user,
      type: action.type,
      photos: action.photos,
      reviews: action.reviews,
      isLoading: false,
      isError: false,
    );
