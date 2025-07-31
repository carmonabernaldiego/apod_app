import '../entities/neo.dart';
import '../repositories/neo_repository.dart';

class GetNeos {
  final NeoRepository repository;
  GetNeos(this.repository);

  Future<List<Neo>> call() async {
    return await repository.getNeos();
  }
}
