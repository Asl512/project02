import 'package:equatable/equatable.dart';

class PhotosExcursionEntity extends Equatable {
  final String idExcursion;
  final List photos;

  const PhotosExcursionEntity({
    required this.idExcursion,
    required this.photos,
  });

  @override
  List<Object?> get props => [idExcursion, photos];
}
