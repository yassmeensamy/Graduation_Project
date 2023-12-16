class AnswerOption {
  final int value;
  final String label;

  AnswerOption({
    required this.value,
    required this.label,
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    return AnswerOption(
      value: json['value'] ,
      label: json['label'] ,
    );
  }
}