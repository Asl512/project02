import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    required code,
    required name,
    required abbreviated,
    required sign,
  }) : super(
          code: code,
          name: name,
          abbreviated: abbreviated,
          sign: sign,
        );

  factory CurrencyModel.fromDocument(DocumentSnapshot snapshot) {
    return CurrencyModel(
      code: snapshot["code"],
      name: snapshot["name"],
      abbreviated: snapshot["abbreviated"],
      sign: snapshot["sign"],
    );
  }
}
