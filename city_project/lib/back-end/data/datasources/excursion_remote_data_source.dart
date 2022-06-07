import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/excursion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExcursionRemoteDataSource {
  Future<List<ExcursionModel>?> getAllExcursion();
  Future<List<ExcursionModel>?> getExcursionByGuide(String id, bool status);
  Future<List<ExcursionModel>?> getExcursionByType(String type);
}

class ExcursionRemoteDataSourceImpl implements ExcursionRemoteDataSource {
  @override
  Future<List<ExcursionModel>?> getAllExcursion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9';
    List response = [];
    await FirebaseFirestore.instance
        .collection('excursion')
        .where("idCity", isEqualTo: idCity)
        .get()
        .then((snapshot) => {response = snapshot.docs});
    try {
      return response.map((excursion) {
        return ExcursionModel.fromDocument(excursion);
      }).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ExcursionModel>?> getExcursionByType(String type) async {
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
      return response.map((excursion) {
        return ExcursionModel.fromDocument(excursion);
      }).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ExcursionModel>?> getExcursionByGuide(String id, bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List response = [];
    await FirebaseFirestore.instance
        .collection('excursion')
        .where("idGuide", isEqualTo: id)
        .where("isCheck", isEqualTo: status)
        .get()
        .then((snapshot) => {response = snapshot.docs});
    try {
      return response.map((excursion) {
        return ExcursionModel.fromDocument(excursion);
      }).toList();
    } catch (e) {
      return null;
    }
  }
}
