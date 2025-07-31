class NeoModel {
  final String name;
  final double diameter;
  final String closeApproachDate;

  NeoModel({
    required this.name,
    required this.diameter,
    required this.closeApproachDate,
  });

  factory NeoModel.fromJson(Map<String, dynamic> json) {
    final diam = json['estimated_diameter']['meters']['estimated_diameter_max']?.toDouble() ?? 0.0;
    final date = (json['close_approach_data'] as List).isNotEmpty
        ? json['close_approach_data'][0]['close_approach_date'] ?? ''
        : '';
    return NeoModel(
      name: json['name'] ?? '',
      diameter: diam,
      closeApproachDate: date,
    );
  }
}
