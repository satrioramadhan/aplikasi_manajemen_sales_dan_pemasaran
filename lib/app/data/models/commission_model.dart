class CommissionModel {
  final int id;
  final int orderId;
  final String commissionType;
  final double? commissionRate;
  final double commissionAmount;
  final String status;
  final DateTime? paidAt;
  final DateTime createdAt;

  CommissionModel({
    required this.id,
    required this.orderId,
    required this.commissionType,
    this.commissionRate,
    required this.commissionAmount,
    required this.status,
    this.paidAt,
    required this.createdAt,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(
      id: json['id'],
      orderId: json['order_id'],
      commissionType: json['commission_type'],
      commissionRate: json['commission_rate'] != null
          ? double.parse(json['commission_rate'].toString())
          : null,
      commissionAmount: double.parse(json['commission_amount'].toString()),
      status: json['status'],
      paidAt:
          json['paid_at'] != null ? DateTime.parse(json['paid_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'commission_type': commissionType,
      'commission_rate': commissionRate,
      'commission_amount': commissionAmount,
      'status': status,
      'paid_at': paidAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
