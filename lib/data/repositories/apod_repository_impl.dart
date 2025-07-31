import '../../domain/entities/apod.dart';
import '../../domain/repositories/apod_repository.dart';
import '../datasources/apod_remote_datasource.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodRemoteDatasource remoteDatasource;
  ApodRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Apod> getApod() async {
    final m = await remoteDatasource.fetchApod();
    return Apod(
      title: m.title,
      url: m.url,
      explanation: m.explanation,
      date: m.date,
    );
  }
}
