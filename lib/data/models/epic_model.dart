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

  /// Construye el modelo a partir del JSON de EPIC, sin API key.
  factory EpicModel.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date'] as String);
    final yyyy = DateFormat('yyyy').format(date);
    final mm   = DateFormat('MM').format(date);
    final dd   = DateFormat('dd').format(date);
    final image = json['image'] as String;
    final url = 'https://epic.gsfc.nasa.gov/archive/natural/'
                '$yyyy/$mm/$dd/png/$image.png';
    return EpicModel(
      caption: json['caption'] as String? ?? '',
      imageUrl: url,
      date: date,
    );
  }
}
