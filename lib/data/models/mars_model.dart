class MarsModel {
  final String imgSrc;
  final String earthDate;
  final String roverName;
  final String cameraName;

  MarsModel({
    required this.imgSrc,
    required this.earthDate,
    required this.roverName,
    required this.cameraName,
  });

  factory MarsModel.fromJson(Map<String, dynamic> json) => MarsModel(
        imgSrc: json['img_src'] ?? '',
        earthDate: json['earth_date'] ?? '',
        roverName: json['rover']['name'] ?? '',
        cameraName: json['camera']['full_name'] ?? '',
      );
}
