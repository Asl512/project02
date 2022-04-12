import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';

abstract class TypeRepository {
  Future<Either<Failure, TypeEntity>> getType(String id);

  Future<Either<Failure, List<TypeEntity>>> getAllType();

  Future<Either<Failure, List<TypeEntity>>> getListType(List<String> listId);
}
