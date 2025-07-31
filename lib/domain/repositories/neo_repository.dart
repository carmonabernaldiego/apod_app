import '../entities/neo.dart';

abstract class NeoRepository {
  Future<List<Neo>> getNeos();
}
