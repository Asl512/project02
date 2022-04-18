import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:lan_code/back-end/redux/user/user_state.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, LoadAuthAction>(_loadAuth),
  TypedReducer<AuthState, GetAuthAction>(_auth),
  TypedReducer<AuthState, NotAuthAction>(_notAuth),
  TypedReducer<AuthState, ErrorAuthAction>(_errorAuth),
]);

AuthState _loadAuth(
  AuthState state,
  LoadAuthAction action,
) =>
    state.copyWith(
      isLoading: true,
      isLoggedIn: false,
      isError: false,
    );

AuthState _notAuth(
  AuthState state,
  NotAuthAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      isLoggedIn: false,
    );

AuthState _errorAuth(
  AuthState state,
  ErrorAuthAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      isLoggedIn: false,
    );

AuthState _auth(
  AuthState state,
  GetAuthAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      isLoggedIn: true,
      token: action.token,
      user: action.user,
    );
