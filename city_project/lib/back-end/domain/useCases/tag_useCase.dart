import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/repositories/tag_repositorie.dart';

class GetAllTag {
  final TagRepository _tagRepository;

  GetAllTag(this._tagRepository);

  Future<List<TagEntity>?> call() async {
    return await _tagRepository.getAllTag();
  }
}

class GetListTag {
  final TagRepository _tagRepository;

  GetListTag(this._tagRepository);

  Future<List<TagEntity>?> call({required List<String> indexes}) async {
    return await _tagRepository.getListTag(indexes: indexes);
  }
}
