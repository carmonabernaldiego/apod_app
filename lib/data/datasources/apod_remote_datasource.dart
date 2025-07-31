import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apod_model.dart';

class ApodRemoteDatasource {
  final String apiKey;
  ApodRemoteDatasource({required this.apiKey});

  Future<ApodModel> fetchApod() async {
    final response = await http.get(
      Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      return ApodModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load APOD');
    }
  }
}
