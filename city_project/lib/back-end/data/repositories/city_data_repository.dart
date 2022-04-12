import 'package:lan_code/back-end/data/datasources/city_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/repositories/city_repositorie.dart';

class CityDataRepository extends CityRepository {
  @override
  Future<List<CityEntiti>?> getAllCity() async {
    return await _getAllCity(() {
      return CityRemoteDataSourceImpl().getAllCity();
    });
  }

  Future<List<CityEntiti>?> _getAllCity(
      Future<List<CityEntiti>?> Function() getAllCity) async {
    final remoteCities = await getAllCity();
    return remoteCities;
  }

  @override
  Future<CityEntiti?> getCity() async {
    final remoteCity = await CityRemoteDataSourceImpl().getCityCash();
    return remoteCity;
  }
}
