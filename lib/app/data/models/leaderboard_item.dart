class LeaderboardItem {
  final int rank;
  final String name;
  final String photo;
  final double sales;
  final int leadsCount;
  final bool isCurrentUser;

  LeaderboardItem({
    required this.rank,
    required this.name,
    required this.photo,
    required this.sales,
    required this.leadsCount,
    this.isCurrentUser = false,
  });

  factory LeaderboardItem.fromJson(Map<String, dynamic> json) {
    return LeaderboardItem(
      rank: json['rank'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      sales: (json['sales'] ?? 0).toDouble(),
      leadsCount: json['leads_count'] ?? 0,
      isCurrentUser: json['is_current_user'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'name': name,
      'photo': photo,
      'sales': sales,
      'leads_count': leadsCount,
      'is_current_user': isCurrentUser,
    };
  }
}
