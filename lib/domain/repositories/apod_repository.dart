import '../entities/apod.dart';

abstract class ApodRepository {
  Future<Apod> getApod();
}
