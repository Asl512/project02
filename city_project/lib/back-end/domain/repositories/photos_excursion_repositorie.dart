import 'package:lan_code/back-end/domain/entities/photos_excursion_entity.dart';

abstract class PhotoExcursionRepository {
  Future<PhotosExcursionEntity?> getPhotoExcursion({required String idExcursion});
}
