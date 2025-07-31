import '../entities/epic.dart';
abstract class EpicRepository {
  Future<List<Epic>> getEpics();
}
