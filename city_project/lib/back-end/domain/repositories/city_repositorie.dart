import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/failure.dart';
import '../entities/city_entity.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityEntiti>>> getAllCity();

  Future<Either<Failure, CityEntiti>> getCity();
}
