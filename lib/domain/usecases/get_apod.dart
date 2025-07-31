import '../entities/apod.dart';
import '../repositories/apod_repository.dart';

class GetApod {
  final ApodRepository repo;
  GetApod(this.repo);
  Future<Apod> call() => repo.getApod();
}
