import 'package:lan_code/back-end/redux/excursion/excursions_actions.dart';
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
      reviews: null,
      userReview: null,
      photos: null,
      isLoading: true,
      isError: false,
      tags: [],
      typesMove: [],
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
      tags: action.tags,
      photos: action.photos,
      userReview: action.usersReview,
      reviews: action.reviews,
      typesMove: action.typesMove,
      isLoading: false,
      isError: false,
    );
