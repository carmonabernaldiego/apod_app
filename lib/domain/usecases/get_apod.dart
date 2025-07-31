import '../entities/apod.dart';
import '../repositories/apod_repository.dart';

class GetApod {
  final ApodRepository repository;
  GetApod(this.repository);

  Future<Apod> call() async {
    return await repository.getApod();
  }
}
