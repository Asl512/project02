import 'package:dartz/dartz.dart';
import 'package:lan_code/feature/domain/entities/excursion_entity.dart';
import '../../../core/failure.dart';

abstract class ExcursionRepository{
  Future<Either<Failure,List<ExcursionEntiti>>> getAllExcursion();
  Future<Either<Failure,List<ExcursionEntiti>>> getExcursionByType(String type);
}