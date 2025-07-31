import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/epic_model.dart';
import 'package:intl/intl.dart';

class EpicRemoteDatasource {
  final String apiKey;
  EpicRemoteDatasource({required this.apiKey});

  Future<List<EpicModel>> fetchEpics() async {
    final response = await http.get(
      Uri.parse('https://api.nasa.gov/EPIC/api/natural?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => EpicModel.fromJson(e, apiKey)).toList();
    } else {
      throw Exception('Failed to load EPIC images');
    }
  }
}
