import '../entities/epic.dart';
import '../repositories/epic_repository.dart';

class GetEpic {
  final EpicRepository repo;
  GetEpic(this.repo);
  Future<List<Epic>> call() => repo.getEpics();
}
