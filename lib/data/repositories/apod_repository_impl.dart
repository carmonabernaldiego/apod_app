import '../../domain/entities/apod.dart';
import '../../domain/repositories/apod_repository.dart';
import '../datasources/apod_remote_datasource.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodRemoteDatasource remoteDatasource;

  ApodRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Apod> getApod() async {
    final model = await remoteDatasource.fetchApod();
    return Apod(
      title: model.title,
      url: model.url,
      explanation: model.explanation,
      date: model.date,
    );
  }
}
