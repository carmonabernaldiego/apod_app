import 'package:flutter/material.dart';
import '../../domain/entities/mars.dart';
import '../../domain/usecases/get_mars.dart';

class MarsProvider with ChangeNotifier {
  final GetMars getMars;
  List<Mars>? photos;
  bool isLoading = false;
  String? error;

  MarsProvider({required this.getMars});

  Future<void> fetchPhotos() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      photos = await getMars();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
