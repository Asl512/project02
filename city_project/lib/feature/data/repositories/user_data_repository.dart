import 'package:dartz/dartz.dart';
import 'package:lan_code/core/exception.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/datasources/user_remote_data_source.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';
import 'package:lan_code/feature/domain/repositories/user_repositorie.dart';

class UserDataRepository extends UserRepository {

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    return await _getUser(() {
      return UserRemoteDataSourceImpl().getUser(id);
    });
  }

  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() getUser) async {
    try {
      final remoteUser = await getUser();
      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure(error: "Пользователь не найден"));
    }
  }
}