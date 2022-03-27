import 'package:equatable/equatable.dart';

class CityEntiti extends Equatable{
  final String id;
  final String name;
  final String photo;

  const CityEntiti({
    required this.id,
    required this.name,
    required this.photo
  });

  @override
  List<Object?> get props => [id, name, photo];
}
