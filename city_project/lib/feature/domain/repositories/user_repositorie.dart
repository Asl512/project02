import 'package:dartz/dartz.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';
import '../../../core/failure.dart';

abstract class UserRepository{
  Future<Either<Failure,UserEntity>> getUser(String id);
}