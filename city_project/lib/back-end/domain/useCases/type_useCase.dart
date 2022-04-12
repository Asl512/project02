import 'package:dartz/dartz.dart';
import 'package:lan_code/back-end/core/failure.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/repositories/type_repositorie.dart';

class GetType {
  final TypeRepository _typeRepository;

  GetType(this._typeRepository);

  Future<Either<Failure, TypeEntity>> call(String id) async {
    return await _typeRepository.getType(id);
  }
}

class GetAllType {
  final TypeRepository _typeRepository;

  GetAllType(this._typeRepository);

  Future<Either<Failure, List<TypeEntity>>> call() async {
    return await _typeRepository.getAllType();
  }
}

class GetListType {
  final TypeRepository _typeRepository;

  GetListType(this._typeRepository);

  Future<Either<Failure, List<TypeEntity>>> call(List<String> listId) async {
    return await _typeRepository.getListType(listId);
  }
}
