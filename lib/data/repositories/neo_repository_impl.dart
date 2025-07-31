import '../../domain/entities/neo.dart';
import '../../domain/repositories/neo_repository.dart';
import '../datasources/neo_remote_datasource.dart';

class NeoRepositoryImpl implements NeoRepository {
  final NeoRemoteDatasource remoteDatasource;
  NeoRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Neo>> getNeos() async {
    final list = await remoteDatasource.fetchNeos();
    return list.map((m) => Neo(
      name: m.name,
      diameter: m.diameter,
      closeApproachDate: m.closeApproachDate,
    )).toList();
  }
}
