import 'package:intl/intl.dart';

class EpicModel {
  final String caption;
  final String imageUrl;
  final DateTime date;

  EpicModel({
    required this.caption,
    required this.imageUrl,
    required this.date,
  });

  factory EpicModel.fromJson(Map<String, dynamic> json, String apiKey) {
    final date = DateTime.parse(json['date']);
    final yyyy = DateFormat('yyyy').format(date);
    final mm   = DateFormat('MM').format(date);
    final dd   = DateFormat('dd').format(date);
    final image = json['image'];
    final url = 'https://api.nasa.gov/EPIC/archive/natural/$yyyy/$mm/$dd/png/$image.png?api_key=$apiKey';
    return EpicModel(
      caption: json['caption'] ?? '',
      imageUrl: url,
      date: date,
    );
  }
}
