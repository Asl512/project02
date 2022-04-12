import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/core/exception.dart';
import 'package:lan_code/back-end/data/models/type_model.dart';

abstract class TypeRemoteDataSource {
  Future<TypeModel> getType(String id);

  Future<List<TypeModel>> getAllType();

  Future<List<TypeModel>> getListType(List<String> listId);
}

class TypeRemoteDataSourceImpl implements TypeRemoteDataSource {
  @override
  Future<TypeModel> getType(String id) async {
    DocumentSnapshot response =
        await FirebaseFirestore.instance.collection('typeExcursion').doc(id).get();
    try {
      if (response["name"] != null) {
        return TypeModel.fromDocument(response);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TypeModel>> getAllType() async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('typeExcursion')
        .get()
        .then((snapshot) => {response = snapshot.docs});
    try {
      if (response.first["name"] != null) {
        return response.map((type) => TypeModel.fromDocument(type)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TypeModel>> getListType(List<String> listId) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('typeExcursion')
        .where('id', whereIn: listId)
        .get()
        .then((snapshot) => {response = snapshot.docs});
    try {
      if (response.first["name"] != null) {
        return response.map((type) => TypeModel.fromDocument(type)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
