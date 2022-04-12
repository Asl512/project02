import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/exception.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/data/datasources/type_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/repositories/type_repositorie.dart';

class TypeDataRepository extends TypeRepository {
  @override
  Future<Either<Failure, List<TypeEntity>>> getAllType() async {
    return await _getListType(() {
      return TypeRemoteDataSourceImpl().getAllType();
    });
  }

  @override
  Future<Either<Failure, List<TypeEntity>>> getListType(List<String> listId) async {
    return await _getListType(() {
      return TypeRemoteDataSourceImpl().getListType(listId);
    });
  }

  Future<Either<Failure, List<TypeEntity>>> _getListType(
      Future<List<TypeEntity>> Function() getAllType) async {
    try {
      final remoteTypes = await getAllType();
      return Right(remoteTypes);
    } on ServerException {
      return Left(ServerFailure(error: "Типы не найдены"));
    }
  }

  @override
  Future<Either<Failure, TypeEntity>> getType(String id) async {
    return await _getType(() {
      return TypeRemoteDataSourceImpl().getType(id);
    });
  }

  Future<Either<Failure, TypeEntity>> _getType(Future<TypeEntity> Function() getCity) async {
    try {
      final remoteType = await getCity();
      return Right(remoteType);
    } on ServerException {
      return Left(ServerFailure(error: "Тип не найден"));
    }
  }
}
