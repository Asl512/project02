import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/repositories/excursion_repositorie.dart';

class GetAllExcursion {
  final ExcursionRepository _excursionRepository;

  GetAllExcursion(this._excursionRepository);

  Future<List<ExcursionEntiti>?> call() async {
    return await _excursionRepository.getAllExcursion();
  }
}

class GetExcursionByType {
  final ExcursionRepository _excursionRepository;

  GetExcursionByType(this._excursionRepository);

  Future<List<ExcursionEntiti>?> call(String type) async {
    return await _excursionRepository.getExcursionByType(type);
  }
}
