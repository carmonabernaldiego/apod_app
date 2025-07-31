import '../../domain/entities/neo.dart';
import '../../domain/repositories/neo_repository.dart';
import '../datasources/neo_remote_datasource.dart';

class NeoRepositoryImpl implements NeoRepository {
  final NeoRemoteDatasource remoteDatasource;

  NeoRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Neo>> getNeos() async {
    final models = await remoteDatasource.fetchNeos();
    return models
        .map((e) => Neo(
              name: e.name,
              diameter: e.diameter,
              closeApproachDate: e.closeApproachDate,
            ))
        .toList();
  }
}
