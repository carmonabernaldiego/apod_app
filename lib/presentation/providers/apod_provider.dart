import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../domain/entities/apod.dart';
import '../../domain/usecases/get_apod.dart';

class ApodProvider with ChangeNotifier {
  final GetApod getApod;
  final GoogleTranslator _translator = GoogleTranslator();

  Apod? apod;
  bool isLoading = false;
  String? error;

  ApodProvider({required this.getApod});

  Future<void> fetchApod() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final data = await getApod();
      final t1 = await _translator.translate(data.title, to: 'es');
      final t2 = await _translator.translate(data.explanation, to: 'es');
      apod = Apod(
        title: t1.text,
        url: data.url,
        explanation: t2.text,
        date: data.date,
      );
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
