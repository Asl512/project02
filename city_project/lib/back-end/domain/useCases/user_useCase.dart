import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/repositories/user_repositorie.dart';

class GetUser {
  final UserRepository _userRepository;

  GetUser(this._userRepository);

  Future<Either<Failure, UserEntity>> call(String id) async {
    return await _userRepository.getUser(id);
  }
}

class GetListUsers {
  final UserRepository _userRepository;

  GetListUsers(this._userRepository);

  Future<Either<Failure, List<UserEntity?>>> call(List<String> listId) async {
    return await _userRepository.getListUsers(listId);
  }
}
