import 'package:lan_code/back-end/data/datasources/excursion_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/repositories/excursion_repositorie.dart';

class ExcursionDataRepository extends ExcursionRepository {
  @override
  Future<List<ExcursionEntity>?> getAllExcursion() async {
    return await _getExcursion(() {
      return ExcursionRemoteDataSourceImpl().getAllExcursion();
    });
  }

  @override
  Future<List<ExcursionEntity>?> getExcursionByType(String type) async {
    return await _getExcursion(() {
      return ExcursionRemoteDataSourceImpl().getExcursionByType(type);
    });
  }

  Future<List<ExcursionEntity>?> _getExcursion(
      Future<List<ExcursionEntity>?> Function() getAllExcursion) async {
    final remoteExcursion = await getAllExcursion();
    return remoteExcursion;
  }
}
