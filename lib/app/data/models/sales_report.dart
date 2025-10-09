class SalesReport {
  final String period;
  final double totalSales;
  final int totalLeads;
  final int convertedLeads;
  final double conversionRate;
  final double commission;

  SalesReport({
    required this.period,
    required this.totalSales,
    required this.totalLeads,
    required this.convertedLeads,
    required this.conversionRate,
    required this.commission,
  });
}

class MonthlySales {
  final String month;
  final double amount;
  final int leads;

  MonthlySales({
    required this.month,
    required this.amount,
    required this.leads,
  });
}

class ProductPerformance {
  final String productName;
  final int totalSold;
  final double revenue;
  final double percentage;

  ProductPerformance({
    required this.productName,
    required this.totalSold,
    required this.revenue,
    required this.percentage,
  });
}
