import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../domain/entities/neo.dart';
import '../../domain/usecases/get_neos.dart';

class NeoProvider with ChangeNotifier {
  final GetNeos getNeosUseCase;
  final GoogleTranslator _translator = GoogleTranslator();

  NeoProvider({required this.getNeosUseCase});

  List<Neo> neos = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchNeos() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final data = await getNeosUseCase();
      neos = await Future.wait(data.map((n) async {
        final nameEs = await _translator.translate(n.name, to: 'es');
        return Neo(
          name: nameEs.text,
          diameter: n.diameter,
          closeApproachDate: n.closeApproachDate,
        );
      }));
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
