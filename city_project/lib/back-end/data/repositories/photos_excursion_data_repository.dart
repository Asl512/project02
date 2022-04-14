import 'package:lan_code/back-end/data/datasources/photos_excursion_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/photos_excursion_entity.dart';
import 'package:lan_code/back-end/domain/repositories/photos_excursion_repositorie.dart';

class PhotosExcursionDataRepository extends PhotoExcursionRepository {

  @override
  Future<PhotosExcursionEntity?> getPhotoExcursion({required String idExcursion}) async {
    final remote = await PhotosExcursionRemoteDataSourceImpl().getPhotosExcursion(idExcursion: idExcursion);
    return remote;
  }
}
