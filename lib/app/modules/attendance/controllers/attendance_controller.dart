import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/models/attendance_model.dart';

class AttendanceController extends GetxController {
  // Observable Variables
  final isLoading = false.obs;
  final attendances = <AttendanceModel>[].obs;
  final todayAttendance = Rx<AttendanceModel?>(null);
  final currentPosition = Rx<Position?>(null);
  final isLocationLoading = false.obs;

  // Location settings
  final double officeLatitude = -6.2088; // Mock office location (Jakarta)
  final double officeLongitude = 106.8456;
  final double maxDistanceInMeters = 500; // 500 meters radius

  @override
  void onInit() {
    super.onInit();
    loadAttendances();
    checkTodayAttendance();
  }

  // Load Attendances (Mock)
  Future<void> loadAttendances() async {
    try {
      isLoading.value = true;

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Attendance Data
      attendances.value = [
        AttendanceModel(
          id: 1,
          salesId: 1,
          checkInTime: DateTime.now().subtract(const Duration(hours: 8)),
          checkOutTime: DateTime.now().subtract(const Duration(hours: 1)),
          checkInLatitude: -6.2088,
          checkInLongitude: 106.8456,
          checkInAddress: 'Jl. Sudirman No. 123, Jakarta',
          checkOutLatitude: -6.2088,
          checkOutLongitude: 106.8456,
          checkOutAddress: 'Jl. Sudirman No. 123, Jakarta',
          status: 'present',
          workDuration: 420, // 7 hours
          createdAt: DateTime.now().subtract(const Duration(days: 0)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
          salesName: 'John Doe',
        ),
        AttendanceModel(
          id: 2,
          salesId: 1,
          checkInTime: DateTime.now().subtract(const Duration(days: 1, hours: 9)),
          checkOutTime:
              DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          checkInLatitude: -6.2088,
          checkInLongitude: 106.8456,
          checkInAddress: 'Jl. Sudirman No. 123, Jakarta',
          checkOutLatitude: -6.2088,
          checkOutLongitude: 106.8456,
          checkOutAddress: 'Jl. Sudirman No. 123, Jakarta',
          status: 'late',
          workDuration: 420,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          salesName: 'John Doe',
        ),
        AttendanceModel(
          id: 3,
          salesId: 1,
          checkInTime: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
          checkOutTime:
              DateTime.now().subtract(const Duration(days: 2, hours: 1)),
          checkInLatitude: -6.2088,
          checkInLongitude: 106.8456,
          checkInAddress: 'Jl. Sudirman No. 123, Jakarta',
          checkOutLatitude: -6.2088,
          checkOutLongitude: 106.8456,
          checkOutAddress: 'Jl. Sudirman No. 123, Jakarta',
          status: 'present',
          workDuration: 420,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
          salesName: 'John Doe',
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load attendance data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Check today's attendance
  void checkTodayAttendance() {
    final today = DateTime.now();
    try {
      final attendance = attendances.firstWhere(
        (att) =>
            att.checkInTime.year == today.year &&
            att.checkInTime.month == today.month &&
            att.checkInTime.day == today.day,
      );
      todayAttendance.value = attendance;
    } catch (e) {
      todayAttendance.value = null;
    }
  }

  // Get current location
  Future<Position?> getCurrentLocation() async {
    try {
      isLocationLoading.value = true;

      // Check location permission
      var status = await Permission.location.status;
      if (!status.isGranted) {
        status = await Permission.location.request();
        if (!status.isGranted) {
          Get.snackbar(
            'Permission Denied',
            'Location permission is required for attendance',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return null;
        }
      }

      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Location Service Disabled',
          'Please enable location service',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      return position;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get location: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLocationLoading.value = false;
    }
  }

  // Calculate distance from office
  double calculateDistance(double lat, double lon) {
    return Geolocator.distanceBetween(
      officeLatitude,
      officeLongitude,
      lat,
      lon,
    );
  }

  // Check if within office radius
  bool isWithinOfficeRadius(Position position) {
    final distance = calculateDistance(
      position.latitude,
      position.longitude,
    );
    return distance <= maxDistanceInMeters;
  }

  // Check-in
  Future<void> checkIn() async {
    try {
      isLoading.value = true;

      // Get current location
      final position = await getCurrentLocation();
      if (position == null) {
        isLoading.value = false;
        return;
      }

      // Validate location (optional - can be disabled for testing)
      // if (!isWithinOfficeRadius(position)) {
      //   Get.snackbar(
      //     'Location Error',
      //     'You are too far from the office. Distance: ${calculateDistance(position.latitude, position.longitude).toStringAsFixed(0)}m',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      //   isLoading.value = false;
      //   return;
      // }

      // TODO: API call to check-in
      await Future.delayed(const Duration(seconds: 1));

      // Mock address (in production, use reverse geocoding)
      final address = 'Jl. Sudirman No. 123, Jakarta';

      // Create new attendance
      final newAttendance = AttendanceModel(
        id: DateTime.now().millisecondsSinceEpoch,
        salesId: 1,
        checkInTime: DateTime.now(),
        checkInLatitude: position.latitude,
        checkInLongitude: position.longitude,
        checkInAddress: address,
        status: 'present',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        salesName: 'John Doe',
      );

      attendances.insert(0, newAttendance);
      todayAttendance.value = newAttendance;

      Get.snackbar(
        'Success',
        'Check-in successful!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check-in: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Check-out
  Future<void> checkOut() async {
    if (todayAttendance.value == null) {
      Get.snackbar(
        'Error',
        'No check-in record found for today',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Get current location
      final position = await getCurrentLocation();
      if (position == null) {
        isLoading.value = false;
        return;
      }

      // TODO: API call to check-out
      await Future.delayed(const Duration(seconds: 1));

      // Mock address
      final address = 'Jl. Sudirman No. 123, Jakarta';

      // Update attendance
      final checkOutTime = DateTime.now();
      final workDuration = checkOutTime
          .difference(todayAttendance.value!.checkInTime)
          .inMinutes;

      final updatedAttendance = AttendanceModel(
        id: todayAttendance.value!.id,
        salesId: todayAttendance.value!.salesId,
        checkInTime: todayAttendance.value!.checkInTime,
        checkOutTime: checkOutTime,
        checkInLatitude: todayAttendance.value!.checkInLatitude,
        checkInLongitude: todayAttendance.value!.checkInLongitude,
        checkInAddress: todayAttendance.value!.checkInAddress,
        checkOutLatitude: position.latitude,
        checkOutLongitude: position.longitude,
        checkOutAddress: address,
        status: todayAttendance.value!.status,
        workDuration: workDuration,
        createdAt: todayAttendance.value!.createdAt,
        updatedAt: DateTime.now(),
        salesName: todayAttendance.value!.salesName,
      );

      final index = attendances
          .indexWhere((att) => att.id == todayAttendance.value!.id);
      if (index != -1) {
        attendances[index] = updatedAttendance;
      }
      todayAttendance.value = updatedAttendance;

      Get.snackbar(
        'Success',
        'Check-out successful! Work duration: ${updatedAttendance.getWorkDurationFormatted()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check-out: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh attendances
  Future<void> refreshAttendances() async {
    await loadAttendances();
    checkTodayAttendance();
  }
}
