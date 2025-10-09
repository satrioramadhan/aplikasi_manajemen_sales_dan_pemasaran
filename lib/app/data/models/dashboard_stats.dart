class DashboardStats {
  final int todayLeads;
  final int monthlyLeads;
  final double monthlyCommission;
  final double kpiProgress;
  final int activitiesCount;
  final int pendingFollowUps;

  DashboardStats({
    required this.todayLeads,
    required this.monthlyLeads,
    required this.monthlyCommission,
    required this.kpiProgress,
    required this.activitiesCount,
    required this.pendingFollowUps,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      todayLeads: json['today_leads'] ?? 0,
      monthlyLeads: json['monthly_leads'] ?? 0,
      monthlyCommission: (json['monthly_commission'] ?? 0).toDouble(),
      kpiProgress: (json['kpi_progress'] ?? 0).toDouble(),
      activitiesCount: json['activities_count'] ?? 0,
      pendingFollowUps: json['pending_follow_ups'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today_leads': todayLeads,
      'monthly_leads': monthlyLeads,
      'monthly_commission': monthlyCommission,
      'kpi_progress': kpiProgress,
      'activities_count': activitiesCount,
      'pending_follow_ups': pendingFollowUps,
    };
  }
}
