import 'package:lan_code/back-end/redux/excursion/excursion_actions.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:redux/redux.dart';

Reducer<ListExcursionsState> allExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadAllExcursionsAction>(_loadAllExcursion),
  TypedReducer<ListExcursionsState, ErrorAllExcursionsAction>(_errorAllExcursions),
  TypedReducer<ListExcursionsState, GetAllExcursionsAction>(_getAllExcursions),
]);

Reducer<ListExcursionsState> groupExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadGroupExcursionsAction>(_loadGroupExcursion),
  TypedReducer<ListExcursionsState, ErrorGroupExcursionsAction>(_errorGroupExcursions),
  TypedReducer<ListExcursionsState, GetGroupExcursionsAction>(_getGroupExcursions),
]);

Reducer<ListExcursionsState> individualExcursionsReducer = combineReducers([
  TypedReducer<ListExcursionsState, LoadIndividualExcursionsAction>(_loadIndividualExcursion),
  TypedReducer<ListExcursionsState, ErrorIndividualExcursionsAction>(_errorIndividualExcursions),
  TypedReducer<ListExcursionsState, GetIndividualExcursionsAction>(_getIndividualExcursions),
]);

Reducer<ExcursionInfoState> excursionInfoReducer = combineReducers([
  TypedReducer<ExcursionInfoState, LoadExcursionInfoAction>(_loadExcursionInfo),
  TypedReducer<ExcursionInfoState, ErrorExcursionInfoAction>(_errorExcursionInfo),
  TypedReducer<ExcursionInfoState, GetExcursionInfoAction>(_getExcursionInfo),
]);

//All excursions
ListExcursionsState _loadAllExcursion(
  ListExcursionsState state,
  LoadAllExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorAllExcursions(
  ListExcursionsState state,
  ErrorAllExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _getAllExcursions(
  ListExcursionsState state,
  GetAllExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currencies,
      users: action.users,
      types: action.types,
      isLoading: false,
      isError: false,
    );

//Group excursions
ListExcursionsState _loadGroupExcursion(
  ListExcursionsState state,
  LoadGroupExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorGroupExcursions(
  ListExcursionsState state,
  ErrorGroupExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _getGroupExcursions(
  ListExcursionsState state,
  GetGroupExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currencies,
      users: action.users,
      types: action.types,
      isLoading: false,
      isError: false,
    );

//Individual excursions
ListExcursionsState _loadIndividualExcursion(
  ListExcursionsState state,
  LoadIndividualExcursionsAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

ListExcursionsState _errorIndividualExcursions(
  ListExcursionsState state,
  ErrorIndividualExcursionsAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

ListExcursionsState _getIndividualExcursions(
  ListExcursionsState state,
  GetIndividualExcursionsAction action,
) =>
    state.copyWith(
      excursions: action.excursions,
      currencies: action.currencies,
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
      currency: action.currency,
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
      currency: action.currency,
      tags: action.tags,
      photos: action.photos,
      userReview: action.usersReview,
      reviews: action.reviews,
      typesMove: action.typesMove,
      isLoading: false,
      isError: false,
    );
