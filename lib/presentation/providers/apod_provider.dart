import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../domain/entities/apod.dart';
import '../../domain/usecases/get_apod.dart';

class ApodProvider with ChangeNotifier {
  final GetApod getApodUseCase;
  final GoogleTranslator _translator = GoogleTranslator();

  ApodProvider({required this.getApodUseCase});

  Apod? apod;
  bool isLoading = false;
  String? error;

  Future<void> fetchApod() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final data = await getApodUseCase();
      final translatedTitle = await _translator.translate(data.title, to: 'es');
      final translatedExplanation = await _translator.translate(data.explanation, to: 'es');
      apod = Apod(
        title: translatedTitle.text,
        url: data.url,
        explanation: translatedExplanation.text,
        date: data.date,
      );
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
