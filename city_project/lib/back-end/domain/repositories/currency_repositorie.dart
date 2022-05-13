import 'package:lan_code/back-end/domain/entities/currency_entity.dart';

abstract class CurrencyRepository {
  Future<List<CurrencyEntity>?> getAllCurrency();

  Future<List<CurrencyEntity>?> getListCurrency({required List<String> codes});
}
