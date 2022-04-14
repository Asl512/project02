import 'package:lan_code/back-end/domain/entities/tag_entity.dart';

abstract class TagRepository {
  Future<List<TagEntity>?> getAllTag();

  Future<List<TagEntity>?> getListTag({required List<String> indexes});
}
