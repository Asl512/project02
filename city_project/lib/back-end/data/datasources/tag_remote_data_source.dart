import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/tag_model.dart';

abstract class TagRemoteDataSource {
  Future<List<TagModel>?> getAllTag();

  Future<List<TagModel>?> getListTag(List<String> indexes);
}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  @override
  Future<List<TagModel>?> getAllTag() async {
    List response = [];
    await FirebaseFirestore.instance.collection('tags').get().then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((tag) => TagModel.fromDocument(tag)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<TagModel>?> getListTag(List<dynamic> indexes) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('typeExcursion')
        .where('id', whereIn: (indexes as List<String>))
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    print(response.length);
    print('===========================');

    try {
      return response.map((tag) => TagModel.fromDocument(tag)).toList();
    } catch (e) {
      return null;
    }
  }
}
