// lib/data/datasources/epic_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/epic_model.dart';

class EpicRemoteDatasource {
  final String apiKey;
  EpicRemoteDatasource({required this.apiKey});

  /// Obtiene imágenes de la fecha más reciente disponible
  Future<List<EpicModel>> fetchLatestEpics() async {
    final uri = Uri.https(
      'api.nasa.gov',
      '/EPIC/api/natural',
      {'api_key': apiKey},
    );

    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Error EPIC: ${resp.statusCode}');
    }

    final List<dynamic> data = json.decode(resp.body);
    return data
        .map((e) => EpicModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
