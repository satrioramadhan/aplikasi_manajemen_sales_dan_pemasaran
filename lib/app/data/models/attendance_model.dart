class AttendanceModel {
  final int id;
  final int salesId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final double checkInLatitude;
  final double checkInLongitude;
  final String? checkInAddress;
  final double? checkOutLatitude;
  final double? checkOutLongitude;
  final String? checkOutAddress;
  final String status; // 'present', 'late', 'on_leave', 'absent'
  final String? notes;
  final int? workDuration; // in minutes
  final DateTime createdAt;
  final DateTime updatedAt;

  // Additional (not in database)
  final String? salesName;

  AttendanceModel({
    required this.id,
    required this.salesId,
    required this.checkInTime,
    this.checkOutTime,
    required this.checkInLatitude,
    required this.checkInLongitude,
    this.checkInAddress,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.checkOutAddress,
    this.status = 'present',
    this.notes,
    this.workDuration,
    required this.createdAt,
    required this.updatedAt,
    this.salesName,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? 0,
      salesId: json['sales_id'] ?? 0,
      checkInTime: json['check_in_time'] != null
          ? DateTime.parse(json['check_in_time'])
          : DateTime.now(),
      checkOutTime: json['check_out_time'] != null
          ? DateTime.parse(json['check_out_time'])
          : null,
      checkInLatitude: (json['check_in_latitude'] ?? 0).toDouble(),
      checkInLongitude: (json['check_in_longitude'] ?? 0).toDouble(),
      checkInAddress: json['check_in_address'],
      checkOutLatitude: json['check_out_latitude'] != null
          ? (json['check_out_latitude']).toDouble()
          : null,
      checkOutLongitude: json['check_out_longitude'] != null
          ? (json['check_out_longitude']).toDouble()
          : null,
      checkOutAddress: json['check_out_address'],
      status: json['status'] ?? 'present',
      notes: json['notes'],
      workDuration: json['work_duration'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      salesName: json['sales_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sales_id': salesId,
      'check_in_time': checkInTime.toIso8601String(),
      'check_out_time': checkOutTime?.toIso8601String(),
      'check_in_latitude': checkInLatitude,
      'check_in_longitude': checkInLongitude,
      'check_in_address': checkInAddress,
      'check_out_latitude': checkOutLatitude,
      'check_out_longitude': checkOutLongitude,
      'check_out_address': checkOutAddress,
      'status': status,
      'notes': notes,
      'work_duration': workDuration,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sales_name': salesName,
    };
  }

  // Check if already checked out
  bool isCheckedOut() {
    return checkOutTime != null;
  }

  // Get work duration in hours
  String getWorkDurationFormatted() {
    if (workDuration == null) return '-';
    final hours = workDuration! ~/ 60;
    final minutes = workDuration! % 60;
    return '${hours}h ${minutes}m';
  }

  // Calculate work duration if checked out
  int? calculateWorkDuration() {
    if (checkOutTime == null) return null;
    return checkOutTime!.difference(checkInTime).inMinutes;
  }

  // Get status color
  String getStatusColor() {
    switch (status) {
      case 'present':
        return 'green';
      case 'late':
        return 'orange';
      case 'on_leave':
        return 'blue';
      case 'absent':
        return 'red';
      default:
        return 'grey';
    }
  }

  // Get formatted date
  String getFormattedDate() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${checkInTime.day} ${months[checkInTime.month - 1]} ${checkInTime.year}';
  }

  // Get formatted time
  String getCheckInTimeFormatted() {
    return '${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}';
  }

  String? getCheckOutTimeFormatted() {
    if (checkOutTime == null) return null;
    return '${checkOutTime!.hour.toString().padLeft(2, '0')}:${checkOutTime!.minute.toString().padLeft(2, '0')}';
  }

  // Get status label
  String getStatusLabel() {
    switch (status) {
      case 'present':
        return 'Present';
      case 'late':
        return 'Late';
      case 'on_leave':
        return 'On Leave';
      case 'absent':
        return 'Absent';
      default:
        return status;
    }
  }
}
