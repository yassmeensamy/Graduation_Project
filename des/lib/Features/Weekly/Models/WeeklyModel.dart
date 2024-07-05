
class WeelklyModel {
  int id;
  String? aspect;
  int? score;
  String? timestamp;

  // Default constructor
  WeelklyModel({
    required this.id,
     this.aspect,
    this.score,
    this.timestamp,

  });

  // Factory constructor to create an instance from a JSON map
  factory WeelklyModel.fromJson(Map<String, dynamic> json) {
    return WeelklyModel(
      id: json['id'],
      aspect: json['name'],
      score: json['value'],
      timestamp: json['date'],
    );
  }

  
}
