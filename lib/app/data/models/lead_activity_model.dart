class LeadActivityModel {
  final int id;
  final int leadId;
  final int salesId;
  final String activityType; // 'call', 'email', 'meeting', 'whatsapp', 'visit', 'other'
  final String? subject;
  final String? notes;
  final DateTime? nextFollowUp;
  final DateTime activityDate;
  final DateTime createdAt;

  // Additional (not in database)
  final String? salesName;

  LeadActivityModel({
    required this.id,
    required this.leadId,
    required this.salesId,
    required this.activityType,
    this.subject,
    this.notes,
    this.nextFollowUp,
    required this.activityDate,
    required this.createdAt,
    this.salesName,
  });

  factory LeadActivityModel.fromJson(Map<String, dynamic> json) {
    return LeadActivityModel(
      id: json['id'] ?? 0,
      leadId: json['lead_id'] ?? 0,
      salesId: json['sales_id'] ?? 0,
      activityType: json['activity_type'] ?? 'other',
      subject: json['subject'],
      notes: json['notes'],
      nextFollowUp: json['next_follow_up'] != null
          ? DateTime.parse(json['next_follow_up'])
          : null,
      activityDate: json['activity_date'] != null
          ? DateTime.parse(json['activity_date'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      salesName: json['sales_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lead_id': leadId,
      'sales_id': salesId,
      'activity_type': activityType,
      'subject': subject,
      'notes': notes,
      'next_follow_up': nextFollowUp?.toIso8601String(),
      'activity_date': activityDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'sales_name': salesName,
    };
  }

  // Get activity icon
  String getActivityIcon() {
    switch (activityType) {
      case 'call':
        return 'phone';
      case 'email':
        return 'email';
      case 'meeting':
        return 'event';
      case 'whatsapp':
        return 'chat';
      case 'visit':
        return 'location_on';
      default:
        return 'note';
    }
  }

  // Get activity color
  String getActivityColor() {
    switch (activityType) {
      case 'call':
        return 'blue';
      case 'email':
        return 'purple';
      case 'meeting':
        return 'green';
      case 'whatsapp':
        return 'teal';
      case 'visit':
        return 'orange';
      default:
        return 'grey';
    }
  }

  // Get time ago
  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(activityDate);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
