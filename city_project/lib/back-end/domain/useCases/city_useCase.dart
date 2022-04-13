
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/repositories/city_repositorie.dart';

class GetAllCity {
  final CityRepository _cityRepository;

  GetAllCity(this._cityRepository);

  Future<List<CityEntity>?> call() async {
    return await _cityRepository.getAllCity();
  }
}

class GetCity {
  final CityRepository _cityRepository;

  GetCity(this._cityRepository);

  Future<CityEntity?> call() async {
    return await _cityRepository.getCity();
  }
}
