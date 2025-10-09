import 'package:intl/intl.dart';

class Formatters {
  // Format currency to IDR
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Format compact currency (e.g., 1.5M, 250K)
  static String formatCompactCurrency(double amount) {
    if (amount >= 1000000000) {
      return 'Rp ${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)}K';
    } else {
      return 'Rp ${amount.toStringAsFixed(0)}';
    }
  }

  // Format percentage
  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }

  // Format date
  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  // Format time
  static String formatTime(DateTime time) {
    final formatter = DateFormat('HH:mm', 'id_ID');
    return formatter.format(time);
  }

  // Format datetime
  static String formatDateTime(DateTime datetime) {
    final formatter = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
    return formatter.format(datetime);
  }

  // Format number with thousands separator
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(number);
  }
}
