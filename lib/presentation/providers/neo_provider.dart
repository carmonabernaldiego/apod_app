import 'package:flutter/material.dart';
import '../../domain/entities/neo.dart';
import '../../domain/usecases/get_neos.dart';

class NeoProvider with ChangeNotifier {
  final GetNeos getNeosUseCase;
  NeoProvider({required this.getNeosUseCase});

  List<Neo> neos = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchNeos() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      neos = await getNeosUseCase();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
