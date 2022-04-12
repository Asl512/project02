import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/core/exception.dart';
import 'package:lan_code/back-end/data/models/excursion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExcursionRemoteDataSource {
  Future<List<ExcursionModel>> getAllExcursion();

  Future<List<ExcursionModel>> getExcursionByType(String type);
}

class ExcursionRemoteDataSourceImpl implements ExcursionRemoteDataSource {
  @override
  Future<List<ExcursionModel>> getAllExcursion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9';
    List response = [];
    await FirebaseFirestore.instance
        .collection('excursion')
        .where("idCity", isEqualTo: idCity)
        .get()
        .then((snapshot) => {response = snapshot.docs});
    try {
      if (response.first["name"] != null) {
        return response.map((excursion){
          print(excursion['name']);
          return ExcursionModel.fromDocument(excursion);
        }).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ExcursionModel>> getExcursionByType(String type) async {
    List response = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9';
    List types = type.split('');
    await FirebaseFirestore.instance
        .collection('excursion')
        .where("idCity", isEqualTo: idCity)
        .where("type", whereIn: types)
        .get()
        .then((snapshot) => {response = snapshot.docs});
    try {
      if (response.first["name"] != null) {
        print(response.length);
        return response.map((excursion) => ExcursionModel.fromDocument(excursion)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
