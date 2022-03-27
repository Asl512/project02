import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../entities/city_entity.dart';

abstract class CityRepository{
  Future<Either<Failure,List<CityEntiti>>> getAllCity();
  Future<Either<Failure,CityEntiti>> getCityCash();
}