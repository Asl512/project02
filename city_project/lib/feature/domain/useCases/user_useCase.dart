import 'package:dartz/dartz.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';
import 'package:lan_code/feature/domain/repositories/user_repositorie.dart';
import '../../../core/failure.dart';

class GetUser{
  final UserRepository _userRepository;

  GetUser(this._userRepository);

  Future<Either<Failure,UserEntity>> call(String id)async{
    return await _userRepository.getUser(id);
  }
}

