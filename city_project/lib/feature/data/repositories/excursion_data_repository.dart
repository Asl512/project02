import 'package:dartz/dartz.dart';
import 'package:lan_code/core/exception.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/datasources/excursion_remote_data_source.dart';
import 'package:lan_code/feature/domain/entities/excursion_entity.dart';
import 'package:lan_code/feature/domain/repositories/excursion_repositorie.dart';

class ExcursionDataRepository extends ExcursionRepository {

  @override
  Future<Either<Failure, List<ExcursionEntiti>>> getAllExcursion()async{
    return await _getExcursion(() {
      return ExcursionRemoteDataSourceImpl().getAllExcursion();
    });
  }

  @override
  Future<Either<Failure, List<ExcursionEntiti>>> getExcursionByType(String type)async{
    return await _getExcursion(() {
      return ExcursionRemoteDataSourceImpl().getExcursionByType(type);
    });
  }

  Future<Either<Failure, List<ExcursionEntiti>>> _getExcursion(
      Future<List<ExcursionEntiti>> Function() getAllExcursion) async {
    try {
      final remoteExcursion = await getAllExcursion();
      return Right(remoteExcursion);
    } on ServerException {
      return Left(ServerFailure(error: "Экскурсии не найдены"));
    }
  }

}