import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/repositories/currency_repositorie.dart';

class GetAllCurrency {
  final CurrencyRepository _currencyRepository;

  GetAllCurrency(this._currencyRepository);

  Future<List<CurrencyEntity>?> call() async {
    return await _currencyRepository.getAllCurrency();
  }
}

class GetListCurrency {
  final CurrencyRepository _currencyRepository;

  GetListCurrency(this._currencyRepository);

  Future<List<CurrencyEntity>?> call({required List<String> codes}) async {
    return await _currencyRepository.getListCurrency(codes: codes);
  }
}
