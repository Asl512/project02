import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyModel>?> getAllCurrency();

  Future<List<CurrencyModel>?> getListCurrency(List<String> codes);
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  @override
  Future<List<CurrencyModel>?> getAllCurrency() async {
    List response = [];
    await FirebaseFirestore.instance.collection('currencies').get().then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((currency) => CurrencyModel.fromDocument(currency)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CurrencyModel>?> getListCurrency(List<String> codes) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('currencies')
        .where('code', whereIn: codes)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((currency) => CurrencyModel.fromDocument(currency)).toList();
    } catch (e) {
      return null;
    }
  }
}
