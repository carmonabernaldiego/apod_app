import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mars_model.dart';

class MarsRemoteDatasource {
  final String apiKey;
  MarsRemoteDatasource({required this.apiKey});

  Future<List<MarsModel>> fetchMarsPhotos() async {
    final resp = await http.get(
      Uri.parse('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/latest_photos?api_key=$apiKey'),
    );
    if (resp.statusCode == 200) {
      final body = json.decode(resp.body);
      // <-- línea corregida: usar latest_photos y proteger null
      final List list = body['latest_photos'] as List<dynamic>? ?? [];
      return list.map((p) => MarsModel.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load Mars photos');
    }
  }
}
