class LeaderboardModel {
  final int rank;
  final int salesId;
  final String salesName;
  final String? salesPhoto;
  final double totalSales;
  final int totalLeads;
  final double achievementPercentage;

  LeaderboardModel({
    required this.rank,
    required this.salesId,
    required this.salesName,
    this.salesPhoto,
    required this.totalSales,
    required this.totalLeads,
    required this.achievementPercentage,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      rank: json['rank'],
      salesId: json['sales_id'],
      salesName: json['sales_name'],
      salesPhoto: json['sales_photo'],
      totalSales: double.parse(json['total_sales'].toString()),
      totalLeads: json['total_leads'],
      achievementPercentage:
          double.parse(json['achievement_percentage'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'sales_id': salesId,
      'sales_name': salesName,
      'sales_photo': salesPhoto,
      'total_sales': totalSales,
      'total_leads': totalLeads,
      'achievement_percentage': achievementPercentage,
    };
  }
}
