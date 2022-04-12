import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/exception.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/data/datasources/user_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/repositories/user_repositorie.dart';

class UserDataRepository extends UserRepository {
  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    return await _getUser(() {
      return UserRemoteDataSourceImpl().getUser(id);
    });
  }

  Future<Either<Failure, UserEntity>> _getUser(Future<UserEntity> Function() getUser) async {
    try {
      final remoteUser = await getUser();
      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure(error: "Пользователь не найден"));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity?>>> getListUsers(List<String> listId) async {
    return await _getListUsers(() {
      return UserRemoteDataSourceImpl().getListUsers(listId);
    });
  }

  Future<Either<Failure, List<UserEntity?>>> _getListUsers(
      Future<List<UserEntity?>> Function() getListUsers) async {
    try {
      final remoteUsers = await getListUsers();
      return Right(remoteUsers);
    } on ServerException {
      return Left(ServerFailure(error: "Пользователи не найден"));
    }
  }
}
