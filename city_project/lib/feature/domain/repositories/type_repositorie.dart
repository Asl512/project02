import 'package:dartz/dartz.dart';
import 'package:lan_code/feature/domain/entities/type_entity.dart';
import '../../../core/failure.dart';

abstract class TypeRepository{
  Future<Either<Failure,TypeEntity>> getType(String id);
  Future<Either<Failure,List<TypeEntity>>> getAllType();
}