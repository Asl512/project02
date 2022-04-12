import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';

abstract class ExcursionRepository {
  Future<Either<Failure, List<ExcursionEntiti>>> getAllExcursion();

  Future<Either<Failure, List<ExcursionEntiti>>> getExcursionByType(String type);
}
