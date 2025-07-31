class ApodModel {
  final String title;
  final String url;
  final String explanation;
  final String date;

  ApodModel({
    required this.title,
    required this.url,
    required this.explanation,
    required this.date,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) => ApodModel(
        title: json['title'] ?? '',
        url: json['url'] ?? '',
        explanation: json['explanation'] ?? '',
        date: json['date'] ?? '',
      );
}
