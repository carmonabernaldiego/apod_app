import 'package:flutter/material.dart';
import '../../domain/entities/apod.dart';
import '../../domain/usecases/get_apod.dart';

class ApodProvider with ChangeNotifier {
  final GetApod getApodUseCase;
  ApodProvider({required this.getApodUseCase});

  Apod? apod;
  bool isLoading = false;
  String? error;

  Future<void> fetchApod() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      apod = await getApodUseCase();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
