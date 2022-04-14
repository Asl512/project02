import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';

abstract class TagRepository {
  Future<List<TypeMoveEntity>?> getAllTypeMove();

  Future<List<TypeMoveEntity>?> getListTypeMove({required List<String> indexes});
}
