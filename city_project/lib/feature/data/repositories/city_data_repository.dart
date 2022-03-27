import 'package:dartz/dartz.dart';
import 'package:lan_code/core/exception.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/datasources/city_remote_data_source.dart';
import 'package:lan_code/feature/domain/entities/city_entity.dart';
import 'package:lan_code/feature/domain/repositories/city_repositorie.dart';

class CityDataRepository extends CityRepository {

  @override
  Future<Either<Failure, List<CityEntiti>>> getAllCity()async{
    return await _getAllCity(() {
      return CityRemoteDataSourceImpl().getAllCity();
    });
  }

  Future<Either<Failure, List<CityEntiti>>> _getAllCity(
      Future<List<CityEntiti>> Function() getAllCity) async {
    try {
      final remoteCities = await getAllCity();
      return Right(remoteCities);
    } on ServerException {
      return Left(ServerFailure(error: "Города не найдены"));
    }
  }

  @override
  Future<Either<Failure, CityEntiti>> getCityCash()async{
    return await _getCityCash(() {
      return CityRemoteDataSourceImpl().getCityCash();
    });
  }

  Future<Either<Failure, CityEntiti>> _getCityCash(
      Future<CityEntiti> Function() getCity) async {
    try {
      final remoteCity = await getCity();
      return Right(remoteCity);
    } on ServerException {
      return Left(ServerFailure(error: "Город не найден"));
    }
  }
}