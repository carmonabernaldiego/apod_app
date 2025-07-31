import '../entities/mars.dart';
import '../repositories/mars_repository.dart';

class GetMars {
  final MarsRepository repo;
  GetMars(this.repo);
  Future<List<Mars>> call() => repo.getMarsPhotos();
}
