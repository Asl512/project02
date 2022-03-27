import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../entities/city_entity.dart';
import '../repositories/city_repositorie.dart';

class GetAllCity{
  final CityRepository _cityRepository;

  GetAllCity(this._cityRepository);

  Future<Either<Failure,List<CityEntiti>>> call()async{
    return await _cityRepository.getAllCity();
  }
}

class GetCity{
  final CityRepository _cityRepository;

  GetCity(this._cityRepository);

  Future<Either<Failure,CityEntiti>> call()async{
    return await _cityRepository.getCityCash();
  }
}