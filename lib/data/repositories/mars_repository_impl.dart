import '../../domain/entities/mars.dart';
import '../../domain/repositories/mars_repository.dart';
import '../datasources/mars_remote_datasource.dart';

class MarsRepositoryImpl implements MarsRepository {
  final MarsRemoteDatasource remoteDatasource;
  MarsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Mars>> getMarsPhotos() async {
    final list = await remoteDatasource.fetchMarsPhotos();
    return list.map((m) => Mars(
      imgSrc: m.imgSrc,
      earthDate: m.earthDate,
      roverName: m.roverName,
      cameraName: m.cameraName,
    )).toList();
  }
}
