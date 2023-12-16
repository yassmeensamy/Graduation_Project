class TestResultModel 
{
  final int total_score;
final String level_of_depression;

  TestResultModel({required this.total_score, required this.level_of_depression});
  
  factory TestResultModel.fromJson(Map<String, dynamic> json)
   {
        return TestResultModel(total_score: json['total_score'],
                          level_of_depression: json['level_of_depression']);
  }

}