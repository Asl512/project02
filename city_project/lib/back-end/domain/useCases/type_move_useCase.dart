import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/repositories/tag_repositorie.dart';
import 'package:lan_code/back-end/domain/repositories/type_move_repositorie.dart';

class GetAllTypeMove {
  final TypeMoveRepository _typeMoveRepository;

  GetAllTypeMove(this._typeMoveRepository);

  Future<List<TypeMoveEntity>?> call() async {
    return await _typeMoveRepository.getAllTypeMove();
  }
}

class GetListTypeMove {
  final TypeMoveRepository _typeMoveRepository;

  GetListTypeMove(this._typeMoveRepository);

  Future<List<TypeMoveEntity>?> call({required List<String> indexes}) async {
    return await _typeMoveRepository.getListTypeMove(indexes: indexes);
  }
}
