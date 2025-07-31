import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/neo_model.dart';

class NeoRemoteDatasource {
  final String apiKey;
  NeoRemoteDatasource({required this.apiKey});

  Future<List<NeoModel>> fetchNeos() async {
    final now = DateTime.now();
    final date = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final url =
        'https://api.nasa.gov/neo/rest/v1/feed?start_date=$date&end_date=$date&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final neos = <NeoModel>[];
      if (body['near_earth_objects'][date] != null) {
        for (var obj in body['near_earth_objects'][date]) {
          neos.add(NeoModel.fromJson(obj));
        }
      }
      return neos;
    } else {
      throw Exception('Failed to load NEOs');
    }
  }
}
