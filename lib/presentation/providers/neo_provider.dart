import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../domain/entities/neo.dart';
import '../../domain/usecases/get_neos.dart';

class NeoProvider with ChangeNotifier {
  final GetNeos getNeos;
  final GoogleTranslator _translator = GoogleTranslator();

  List<Neo> neos = [];
  bool isLoading = false;
  String? error;

  NeoProvider({required this.getNeos});

  Future<void> fetchNeos() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final data = await getNeos();
      neos = await Future.wait(data.map((n) async {
        final t = await _translator.translate(n.name, to: 'es');
        return Neo(
          name: t.text,
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
