import '../entities/neo.dart';
import '../repositories/neo_repository.dart';

class GetNeos {
  final NeoRepository repo;
  GetNeos(this.repo);
  Future<List<Neo>> call() => repo.getNeos();
}
