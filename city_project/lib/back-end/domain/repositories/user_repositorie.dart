import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String id);

  Future<Either<Failure, List<UserEntity?>>> getListUsers(List<String> listId);
}
