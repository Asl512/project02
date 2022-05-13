import 'package:lan_code/back-end/data/datasources/currency_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/repositories/currency_repositorie.dart';

class CurrencyDataRepository extends CurrencyRepository {
  @override
  Future<List<CurrencyEntity>?> getAllCurrency() async {
    return await _getListCurrency(() {
      return CurrencyRemoteDataSourceImpl().getAllCurrency();
    });
  }

  @override
  Future<List<CurrencyEntity>?> getListCurrency({required List<String> codes}) async {
    return await _getListCurrency(() {
      return CurrencyRemoteDataSourceImpl().getListCurrency(codes);
    });
  }

  Future<List<CurrencyEntity>?> _getListCurrency(
      Future<List<CurrencyEntity>?> Function() getCurrency) async {
    final remoteCurrency = await getCurrency();
    return remoteCurrency;
  }
}
