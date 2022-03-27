import 'package:dartz/dartz.dart';
import 'package:lan_code/core/exception.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/datasources/type_remote_data_source.dart';
import 'package:lan_code/feature/domain/entities/type_entity.dart';
import 'package:lan_code/feature/domain/repositories/type_repositorie.dart';

class TypeDataRepository extends TypeRepository {

  @override
  Future<Either<Failure, List<TypeEntity>>> getAllType()async{
    return await _getAllType(() {
      return TypeRemoteDataSourceImpl().getAllType();
    });
  }

  Future<Either<Failure, List<TypeEntity>>> _getAllType(
      Future<List<TypeEntity>> Function() getAllType) async {
    try {
      final remoteTypes = await getAllType();
      return Right(remoteTypes);
    } on ServerException {
      return Left(ServerFailure(error: "Типы не найдены"));
    }
  }

  @override
  Future<Either<Failure, TypeEntity>> getType(String id)async{
    return await _getType(() {
      return TypeRemoteDataSourceImpl().getType(id);
    });
  }

  Future<Either<Failure, TypeEntity>> _getType(
      Future<TypeEntity> Function() getCity) async {
    try {
      final remoteType = await getCity();
      return Right(remoteType);
    } on ServerException {
      return Left(ServerFailure(error: "Тип не найден"));
    }
  }
}