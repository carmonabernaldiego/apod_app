// lib/presentation/providers/epic_provider.dart
import 'package:flutter/material.dart';
import '../../domain/entities/epic.dart';
import '../../domain/usecases/get_epic.dart';

class EpicProvider with ChangeNotifier {
  final GetEpic getEpic;
  List<Epic>? epics;
  bool isLoading = false;
  String? error;

  EpicProvider({required this.getEpic});

  Future<void> fetchEpics() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      epics = await getEpic();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
