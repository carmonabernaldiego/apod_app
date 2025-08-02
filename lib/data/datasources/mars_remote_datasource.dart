import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/mars_model.dart';

class MarsRemoteDatasource {
  final String apiKey;
  MarsRemoteDatasource({required this.apiKey});

  Future<List<MarsModel>> fetchMarsPhotos() async {
    // 1) Intentar por fecha terrestre actual
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final dateUri = Uri.https(
      'api.nasa.gov',
      '/mars-photos/api/v1/rovers/curiosity/photos',
      {
        'earth_date': today,
        'api_key': apiKey,
      },
    );
    final dateResp = await http.get(dateUri);
    if (dateResp.statusCode != 200) {
      throw Exception('Error cargando fotos por fecha: ${dateResp.statusCode}');
    }
    final dateBody = json.decode(dateResp.body) as Map<String, dynamic>;
    final byDate = (dateBody['photos'] as List<dynamic>? ?? [])
        .map((p) => MarsModel.fromJson(p as Map<String, dynamic>))
        .toList();

    if (byDate.isNotEmpty) {
      // Si hay fotos de hoy, las devolvemos
      return byDate;
    }

    // 2) Fallback: si hoy no hay nada, consultamos el manifiesto para el último sol
    final manifestUri = Uri.https(
      'api.nasa.gov',
      '/mars-photos/api/v1/manifests/curiosity',
      {'api_key': apiKey},
    );
    final manifestResp = await http.get(manifestUri);
    if (manifestResp.statusCode != 200) {
      throw Exception('Error cargando manifiesto: ${manifestResp.statusCode}');
    }
    final manifest = json.decode(manifestResp.body) as Map<String, dynamic>;
    final maxSol = manifest['photo_manifest']['max_sol'] as int;

    // 3) Pedir fotos de ese sol
    final solUri = Uri.https(
      'api.nasa.gov',
      '/mars-photos/api/v1/rovers/curiosity/photos',
      {
        'sol': maxSol.toString(),
        'api_key': apiKey,
      },
    );
    final solResp = await http.get(solUri);
    if (solResp.statusCode != 200) {
      throw Exception('Error cargando fotos por sol: ${solResp.statusCode}');
    }
    final solBody = json.decode(solResp.body) as Map<String, dynamic>;
    final bySol = (solBody['photos'] as List<dynamic>? ?? [])
        .map((p) => MarsModel.fromJson(p as Map<String, dynamic>))
        .toList();

    return bySol;
  }
}
