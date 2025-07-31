import '../entities/mars.dart';
abstract class MarsRepository {
  Future<List<Mars>> getMarsPhotos();
}
