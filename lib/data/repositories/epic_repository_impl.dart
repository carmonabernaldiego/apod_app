import '../../domain/entities/epic.dart';
import '../../domain/repositories/epic_repository.dart';
import '../datasources/epic_remote_datasource.dart';

class EpicRepositoryImpl implements EpicRepository {
  final EpicRemoteDatasource remoteDatasource;
  EpicRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Epic>> getEpics() async {
    final list = await remoteDatasource.fetchEpics();
    return list.map((m) => Epic(
      caption: m.caption,
      imageUrl: m.imageUrl,
      date: m.date,
    )).toList();
  }
}
