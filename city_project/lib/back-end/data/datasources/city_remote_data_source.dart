import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/city_model.dart';

abstract class CityRemoteDataSource {
  Future<List<CityModel>?> getAllCity();

  Future<CityEntiti?> getCityCash();
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  @override
  Future<List<CityModel>?> getAllCity() async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('city')
        .get()
        .then((snapshot) => {response = snapshot.docs});

    try {
      return response.map((city) => CityModel.fromDocument(city)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CityEntiti?> getCityCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ///поработать какой id при первом запуске брать
    String idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9';
    DocumentSnapshot response;
    response = await FirebaseFirestore.instance.collection('city').doc(idCity).get();
    try {
      return CityModel.fromDocument(response);
    } catch (e) {
      return null;
    }
  }
}
