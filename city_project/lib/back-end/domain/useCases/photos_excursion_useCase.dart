import 'package:lan_code/back-end/domain/entities/photos_excursion_entity.dart';
import 'package:lan_code/back-end/domain/repositories/photos_excursion_repositorie.dart';

class GetPhotosExcursion {
  final PhotoExcursionRepository _photoExcursionRepository;

  GetPhotosExcursion(this._photoExcursionRepository);

  Future<PhotosExcursionEntity?> call({required String idExcursion}) async {
    return await _photoExcursionRepository.getPhotoExcursion(idExcursion: idExcursion);
  }
}
