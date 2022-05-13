import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final String name;
  final String sign;
  final String code;
  final String abbreviated;

  const CurrencyEntity({
    required this.code,
    required this.name,
    required this.sign,
    required this.abbreviated,
  });

  @override
  List<Object?> get props => [
        code,
        name,
        sign,
        abbreviated,
      ];
}
