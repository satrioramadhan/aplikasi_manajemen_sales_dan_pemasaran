class KpiModel {
  final int id;
  final String name;
  final String metricType;
  final double targetValue;
  final double actualValue;
  final double achievementPercentage;
  final String status;
  final DateTime periodStart;
  final DateTime periodEnd;

  KpiModel({
    required this.id,
    required this.name,
    required this.metricType,
    required this.targetValue,
    required this.actualValue,
    required this.achievementPercentage,
    required this.status,
    required this.periodStart,
    required this.periodEnd,
  });

  factory KpiModel.fromJson(Map<String, dynamic> json) {
    return KpiModel(
      id: json['id'],
      name: json['name'],
      metricType: json['metric_type'],
      targetValue: double.parse(json['target_value'].toString()),
      actualValue: double.parse(json['actual_value'].toString()),
      achievementPercentage:
          double.parse(json['achievement_percentage'].toString()),
      status: json['status'],
      periodStart: DateTime.parse(json['period_start']),
      periodEnd: DateTime.parse(json['period_end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'metric_type': metricType,
      'target_value': targetValue,
      'actual_value': actualValue,
      'achievement_percentage': achievementPercentage,
      'status': status,
      'period_start': periodStart.toIso8601String(),
      'period_end': periodEnd.toIso8601String(),
    };
  }
}
