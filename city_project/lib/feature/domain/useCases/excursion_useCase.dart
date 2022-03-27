import 'package:dartz/dartz.dart';
import 'package:lan_code/feature/domain/entities/excursion_entity.dart';
import 'package:lan_code/feature/domain/repositories/excursion_repositorie.dart';
import '../../../core/failure.dart';

class GetAllExcursion{
  final ExcursionRepository _excursionRepository;

  GetAllExcursion(this._excursionRepository);

  Future<Either<Failure,List<ExcursionEntiti>>> call()async{
    return await _excursionRepository.getAllExcursion();
  }
}

class GetExcursionByType{
  final ExcursionRepository _excursionRepository;

  GetExcursionByType(this._excursionRepository);

  Future<Either<Failure,List<ExcursionEntiti>>> call(String type)async{
    return await _excursionRepository.getExcursionByType(type);
  }
}