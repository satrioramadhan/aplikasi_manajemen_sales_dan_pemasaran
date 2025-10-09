import 'package:get/get.dart';
import '../../../data/models/sales_report.dart';

class ReportsController extends GetxController {
  final isLoading = false.obs;
  final selectedPeriod = 'This Month'.obs;
  final currentReport = Rx<SalesReport?>(null);
  final monthlySales = <MonthlySales>[].obs;
  final productPerformance = <ProductPerformance>[].obs;

  final List<String> periods = [
    'This Week',
    'This Month',
    'Last Month',
    'This Year',
  ];

  @override
  void onInit() {
    super.onInit();
    loadReportData();
  }

  Future<void> loadReportData() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Current Period Report
      currentReport.value = SalesReport(
        period: selectedPeriod.value,
        totalSales: 125500000,
        totalLeads: 87,
        convertedLeads: 45,
        conversionRate: 51.7,
        commission: 12550000,
      );

      // Mock Monthly Sales (Last 6 months)
      monthlySales.value = [
        MonthlySales(month: 'May', amount: 98000000, leads: 62),
        MonthlySales(month: 'Jun', amount: 112000000, leads: 71),
        MonthlySales(month: 'Jul', amount: 105000000, leads: 68),
        MonthlySales(month: 'Aug', amount: 128000000, leads: 79),
        MonthlySales(month: 'Sep', amount: 135000000, leads: 84),
        MonthlySales(month: 'Oct', amount: 125500000, leads: 87),
      ];

      // Mock Product Performance
      productPerformance.value = [
        ProductPerformance(
          productName: 'Product A',
          totalSold: 45,
          revenue: 52500000,
          percentage: 41.8,
        ),
        ProductPerformance(
          productName: 'Product B',
          totalSold: 32,
          revenue: 38200000,
          percentage: 30.4,
        ),
        ProductPerformance(
          productName: 'Product C',
          totalSold: 28,
          revenue: 24800000,
          percentage: 19.8,
        ),
        ProductPerformance(
          productName: 'Others',
          totalSold: 15,
          revenue: 10000000,
          percentage: 8.0,
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load report data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;
    loadReportData();
  }

  Future<void> refreshReports() async {
    await loadReportData();
  }

  void exportReport() {
    Get.snackbar(
      'Coming Soon',
      'Export report feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
