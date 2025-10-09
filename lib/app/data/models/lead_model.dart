class LeadModel {
  final int id;
  final int companyId;
  final int? productId;
  final int? salesId;
  final String leadSource; // 'online', 'offline', 'referral', 'landing_page', 'manual'
  final String? referralLink;

  // Customer Info
  final String customerName;
  final String? customerEmail;
  final String customerPhone;
  final String? customerAddress;
  final String? customerCity;
  final String? customerProvince;

  // Lead Details
  final String status; // 'new', 'contacted', 'qualified', 'proposal', 'negotiation', 'won', 'lost'
  final String priority; // 'low', 'medium', 'high', 'urgent'
  final double? estimatedValue;
  final String? notes;
  final String? lostReason;

  final DateTime? assignedAt;
  final DateTime? lastContactAt;
  final DateTime? closedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Additional (not in database but useful)
  final String? productName;
  final String? salesName;

  LeadModel({
    required this.id,
    required this.companyId,
    this.productId,
    this.salesId,
    required this.leadSource,
    this.referralLink,
    required this.customerName,
    this.customerEmail,
    required this.customerPhone,
    this.customerAddress,
    this.customerCity,
    this.customerProvince,
    this.status = 'new',
    this.priority = 'medium',
    this.estimatedValue,
    this.notes,
    this.lostReason,
    this.assignedAt,
    this.lastContactAt,
    this.closedAt,
    required this.createdAt,
    required this.updatedAt,
    this.productName,
    this.salesName,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      productId: json['product_id'],
      salesId: json['sales_id'],
      leadSource: json['lead_source'] ?? 'manual',
      referralLink: json['referral_link'],
      customerName: json['customer_name'] ?? '',
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'] ?? '',
      customerAddress: json['customer_address'],
      customerCity: json['customer_city'],
      customerProvince: json['customer_province'],
      status: json['status'] ?? 'new',
      priority: json['priority'] ?? 'medium',
      estimatedValue: json['estimated_value'] != null
          ? (json['estimated_value']).toDouble()
          : null,
      notes: json['notes'],
      lostReason: json['lost_reason'],
      assignedAt: json['assigned_at'] != null
          ? DateTime.parse(json['assigned_at'])
          : null,
      lastContactAt: json['last_contact_at'] != null
          ? DateTime.parse(json['last_contact_at'])
          : null,
      closedAt:
          json['closed_at'] != null ? DateTime.parse(json['closed_at']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      productName: json['product_name'],
      salesName: json['sales_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'product_id': productId,
      'sales_id': salesId,
      'lead_source': leadSource,
      'referral_link': referralLink,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone': customerPhone,
      'customer_address': customerAddress,
      'customer_city': customerCity,
      'customer_province': customerProvince,
      'status': status,
      'priority': priority,
      'estimated_value': estimatedValue,
      'notes': notes,
      'lost_reason': lostReason,
      'assigned_at': assignedAt?.toIso8601String(),
      'last_contact_at': lastContactAt?.toIso8601String(),
      'closed_at': closedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'product_name': productName,
      'sales_name': salesName,
    };
  }

  // Get initial of customer name
  String getInitial() {
    if (customerName.isEmpty) return '?';
    final names = customerName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return customerName[0].toUpperCase();
  }

  // Get status color
  String getStatusColor() {
    switch (status) {
      case 'new':
        return 'blue';
      case 'contacted':
        return 'purple';
      case 'qualified':
        return 'orange';
      case 'proposal':
        return 'yellow';
      case 'negotiation':
        return 'cyan';
      case 'won':
        return 'green';
      case 'lost':
        return 'red';
      default:
        return 'grey';
    }
  }

  // Get priority color
  String getPriorityColor() {
    switch (priority) {
      case 'urgent':
        return 'red';
      case 'high':
        return 'orange';
      case 'medium':
        return 'blue';
      case 'low':
        return 'grey';
      default:
        return 'grey';
    }
  }

  // Check if lead is closed
  bool isClosed() {
    return status == 'won' || status == 'lost';
  }

  // Get days since created
  int getDaysSinceCreated() {
    return DateTime.now().difference(createdAt).inDays;
  }

  // Get days since last contact
  int? getDaysSinceLastContact() {
    if (lastContactAt == null) return null;
    return DateTime.now().difference(lastContactAt!).inDays;
  }

  String get statusLabel {
    switch (status) {
      case 'new':
        return 'New';
      case 'contacted':
        return 'Contacted';
      case 'qualified':
        return 'Qualified';
      case 'proposal':
        return 'Proposal';
      case 'negotiation':
        return 'Negotiation';
      case 'won':
        return 'Won';
      case 'lost':
        return 'Lost';
      default:
        return status;
    }
  }

  String get priorityLabel {
    switch (priority) {
      case 'low':
        return 'Low';
      case 'medium':
        return 'Medium';
      case 'high':
        return 'High';
      case 'urgent':
        return 'Urgent';
      default:
        return priority;
    }
  }
}
