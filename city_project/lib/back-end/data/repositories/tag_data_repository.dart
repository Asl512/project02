import 'package:lan_code/back-end/data/datasources/tag_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/repositories/tag_repositorie.dart';

class TagDataRepository extends TagRepository {
  @override
  Future<List<TagEntity>?> getAllTag() async {
    return await _getListTag(() {
      return TagRemoteDataSourceImpl().getAllTag();
    });
  }

  @override
  Future<List<TagEntity>?> getListTag({required List<dynamic> indexes}) async {
    return await _getListTag(() {
      return TagRemoteDataSourceImpl().getListTag(indexes);
    });
  }

  Future<List<TagEntity>?> _getListTag(
      Future<List<TagEntity>?> Function() getTags) async {
    final remoteTags = await getTags();
    return remoteTags;
  }
}
