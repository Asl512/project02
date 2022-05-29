import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

part 'user_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoggedIn,
    @Default(false) bool isError,
    String? token,
    UserEntity? user,
  }) = _AuthState;
}