import 'package:get/get.dart';
import '../../../data/models/lead_model.dart';
import '../../../data/models/lead_activity_model.dart';

class LeadController extends GetxController {
  // Observable Variables
  final isLoading = false.obs;
  final leads = <LeadModel>[].obs;
  final filteredLeads = <LeadModel>[].obs;
  final selectedStatus = 'All'.obs;
  final searchQuery = ''.obs;

  // Statuses for filter
  final statuses = <String>[
    'All',
    'new',
    'contacted',
    'qualified',
    'proposal',
    'negotiation',
    'won',
    'lost',
  ].obs;

  // Lead activities
  final leadActivities = <int, RxList<LeadActivityModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadLeads();
  }

  // Load Leads (Mock)
  Future<void> loadLeads() async {
    try {
      isLoading.value = true;

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Leads Data
      leads.value = [
        LeadModel(
          id: 1,
          companyId: 1,
          productId: 1,
          salesId: 1,
          leadSource: 'landing_page',
          referralLink: 'https://promo.example.com?ref=SALES123',
          customerName: 'PT Maju Jaya Sentosa',
          customerEmail: 'info@majujaya.com',
          customerPhone: '0218765432',
          customerAddress: 'Jl. Sudirman No. 123',
          customerCity: 'Jakarta',
          customerProvince: 'DKI Jakarta',
          status: 'new',
          priority: 'high',
          estimatedValue: 25000000,
          notes: 'Tertarik dengan paket premium laptop untuk kantor',
          productName: 'Premium Laptop Dell XPS 15',
          salesName: 'John Doe',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        LeadModel(
          id: 2,
          companyId: 1,
          productId: 2,
          salesId: 1,
          leadSource: 'referral',
          customerName: 'CV Sukses Mandiri',
          customerEmail: 'contact@suksesmandiri.co.id',
          customerPhone: '0217654321',
          customerAddress: 'Jl. Gatot Subroto No. 45',
          customerCity: 'Jakarta',
          customerProvince: 'DKI Jakarta',
          status: 'contacted',
          priority: 'medium',
          estimatedValue: 12000000,
          notes: 'Follow up untuk presentasi produk minggu depan',
          productName: 'Smartphone Samsung Galaxy S23',
          salesName: 'John Doe',
          lastContactAt: DateTime.now().subtract(const Duration(days: 1)),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        LeadModel(
          id: 3,
          companyId: 1,
          productId: 3,
          salesId: 1,
          leadSource: 'manual',
          customerName: 'UD Berkah Abadi',
          customerEmail: 'berkah@gmail.com',
          customerPhone: '081234567890',
          customerAddress: 'Jl. Ahmad Yani No. 78',
          customerCity: 'Bandung',
          customerProvince: 'Jawa Barat',
          status: 'qualified',
          priority: 'urgent',
          estimatedValue: 5500000,
          notes: 'Sudah deal harga, tinggal tunggu approval dari pemilik',
          productName: 'Wireless Headphone Sony WH-1000XM5',
          salesName: 'John Doe',
          lastContactAt: DateTime.now().subtract(const Duration(hours: 12)),
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        ),
        LeadModel(
          id: 4,
          companyId: 1,
          productId: 4,
          salesId: 1,
          leadSource: 'online',
          customerName: 'Toko Elektronik Jaya',
          customerEmail: 'jaya.electronics@yahoo.com',
          customerPhone: '0219876543',
          customerAddress: 'Jl. Thamrin No. 99',
          customerCity: 'Jakarta',
          customerProvince: 'DKI Jakarta',
          status: 'proposal',
          priority: 'high',
          estimatedValue: 7500000,
          notes: 'Sudah kirim proposal, menunggu review dari owner',
          productName: 'Smart Watch Apple Watch Series 8',
          salesName: 'John Doe',
          lastContactAt: DateTime.now().subtract(const Duration(days: 2)),
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        LeadModel(
          id: 5,
          companyId: 1,
          productId: 5,
          salesId: 1,
          leadSource: 'referral',
          customerName: 'Cafe Kopi Nusantara',
          customerEmail: 'kopinusantara@gmail.com',
          customerPhone: '08123456789',
          customerAddress: 'Jl. Braga No. 12',
          customerCity: 'Bandung',
          customerProvince: 'Jawa Barat',
          status: 'won',
          priority: 'medium',
          estimatedValue: 350000,
          notes: 'Deal! Pelanggan puas dan akan langganan bulanan',
          productName: 'Premium Coffee Subscription',
          salesName: 'John Doe',
          lastContactAt: DateTime.now().subtract(const Duration(days: 1)),
          closedAt: DateTime.now().subtract(const Duration(days: 1)),
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        LeadModel(
          id: 6,
          companyId: 1,
          productId: 6,
          salesId: 1,
          leadSource: 'manual',
          customerName: 'UMKM Digital Kreatif',
          customerEmail: 'digitalkreatif@outlook.com',
          customerPhone: '08198765432',
          customerAddress: 'Jl. Cihampelas No. 56',
          customerCity: 'Bandung',
          customerProvince: 'Jawa Barat',
          status: 'lost',
          priority: 'low',
          estimatedValue: 15000000,
          notes: 'Budget tidak mencukupi, minta postpone 3 bulan',
          lostReason: 'Budget constraints',
          productName: 'Digital Marketing Package',
          salesName: 'John Doe',
          lastContactAt: DateTime.now().subtract(const Duration(days: 5)),
          closedAt: DateTime.now().subtract(const Duration(days: 5)),
          createdAt: DateTime.now().subtract(const Duration(days: 14)),
          updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];

      // Mock Activities for each lead
      _loadMockActivities();

      filteredLeads.value = leads;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load leads',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Load mock activities
  void _loadMockActivities() {
    leadActivities[1] = <LeadActivityModel>[
      LeadActivityModel(
        id: 1,
        leadId: 1,
        salesId: 1,
        activityType: 'call',
        subject: 'Initial contact call',
        notes: 'Menghubungi customer untuk perkenalan produk',
        activityDate: DateTime.now().subtract(const Duration(hours: 2)),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        salesName: 'John Doe',
      ),
    ].obs;

    leadActivities[2] = <LeadActivityModel>[
      LeadActivityModel(
        id: 2,
        leadId: 2,
        salesId: 1,
        activityType: 'meeting',
        subject: 'Presentation meeting',
        notes: 'Meeting untuk presentasi produk Samsung Galaxy S23',
        nextFollowUp: DateTime.now().add(const Duration(days: 7)),
        activityDate: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        salesName: 'John Doe',
      ),
      LeadActivityModel(
        id: 3,
        leadId: 2,
        salesId: 1,
        activityType: 'call',
        subject: 'Follow up call',
        notes: 'Menanyakan hasil diskusi internal customer',
        activityDate: DateTime.now().subtract(const Duration(days: 3)),
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        salesName: 'John Doe',
      ),
    ].obs;

    leadActivities[3] = <LeadActivityModel>[
      LeadActivityModel(
        id: 4,
        leadId: 3,
        salesId: 1,
        activityType: 'visit',
        subject: 'Site visit',
        notes: 'Kunjungan ke lokasi customer untuk demo produk',
        activityDate: DateTime.now().subtract(const Duration(hours: 12)),
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        salesName: 'John Doe',
      ),
    ].obs;
  }

  // Filter by status
  void filterByStatus(String status) {
    selectedStatus.value = status;
    _applyFilters();
  }

  // Search leads
  void searchLeads(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  // Apply filters
  void _applyFilters() {
    var result = leads.toList();

    // Filter by status
    if (selectedStatus.value != 'All') {
      result = result
          .where((lead) => lead.status == selectedStatus.value)
          .toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      result = result.where((lead) {
        final query = searchQuery.value.toLowerCase();
        return lead.customerName.toLowerCase().contains(query) ||
            lead.customerPhone.contains(query) ||
            (lead.customerEmail?.toLowerCase().contains(query) ?? false) ||
            (lead.productName?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    filteredLeads.value = result;
  }

  // Refresh leads
  Future<void> refreshLeads() async {
    await loadLeads();
  }

  // Get lead by ID
  LeadModel? getLeadById(int id) {
    try {
      return leads.firstWhere((lead) => lead.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get activities for lead
  List<LeadActivityModel> getActivitiesForLead(int leadId) {
    return leadActivities[leadId]?.toList() ?? [];
  }

  // Update lead status
  Future<void> updateLeadStatus(int leadId, String newStatus,
      {String? lostReason}) async {
    try {
      // TODO: API call to update status
      await Future.delayed(const Duration(milliseconds: 500));

      final leadIndex = leads.indexWhere((lead) => lead.id == leadId);
      if (leadIndex != -1) {
        final updatedLead = LeadModel(
          id: leads[leadIndex].id,
          companyId: leads[leadIndex].companyId,
          productId: leads[leadIndex].productId,
          salesId: leads[leadIndex].salesId,
          leadSource: leads[leadIndex].leadSource,
          referralLink: leads[leadIndex].referralLink,
          customerName: leads[leadIndex].customerName,
          customerEmail: leads[leadIndex].customerEmail,
          customerPhone: leads[leadIndex].customerPhone,
          customerAddress: leads[leadIndex].customerAddress,
          customerCity: leads[leadIndex].customerCity,
          customerProvince: leads[leadIndex].customerProvince,
          status: newStatus,
          priority: leads[leadIndex].priority,
          estimatedValue: leads[leadIndex].estimatedValue,
          notes: leads[leadIndex].notes,
          lostReason: lostReason ?? leads[leadIndex].lostReason,
          assignedAt: leads[leadIndex].assignedAt,
          lastContactAt: leads[leadIndex].lastContactAt,
          closedAt: (newStatus == 'won' || newStatus == 'lost')
              ? DateTime.now()
              : leads[leadIndex].closedAt,
          createdAt: leads[leadIndex].createdAt,
          updatedAt: DateTime.now(),
          productName: leads[leadIndex].productName,
          salesName: leads[leadIndex].salesName,
        );

        leads[leadIndex] = updatedLead;
        _applyFilters();

        Get.snackbar(
          'Success',
          'Lead status updated to ${newStatus.toUpperCase()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update lead status',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Add activity
  Future<void> addActivity({
    required int leadId,
    required String activityType,
    required String subject,
    String? notes,
    DateTime? nextFollowUp,
  }) async {
    try {
      // TODO: API call to add activity
      await Future.delayed(const Duration(milliseconds: 500));

      final newActivity = LeadActivityModel(
        id: DateTime.now().millisecondsSinceEpoch,
        leadId: leadId,
        salesId: 1, // Current user ID
        activityType: activityType,
        subject: subject,
        notes: notes,
        nextFollowUp: nextFollowUp,
        activityDate: DateTime.now(),
        createdAt: DateTime.now(),
        salesName: 'John Doe',
      );

      if (leadActivities[leadId] == null) {
        leadActivities[leadId] = <LeadActivityModel>[].obs;
      }
      leadActivities[leadId]!.insert(0, newActivity);

      // Update last contact
      final leadIndex = leads.indexWhere((lead) => lead.id == leadId);
      if (leadIndex != -1) {
        final updatedLead = LeadModel(
          id: leads[leadIndex].id,
          companyId: leads[leadIndex].companyId,
          productId: leads[leadIndex].productId,
          salesId: leads[leadIndex].salesId,
          leadSource: leads[leadIndex].leadSource,
          referralLink: leads[leadIndex].referralLink,
          customerName: leads[leadIndex].customerName,
          customerEmail: leads[leadIndex].customerEmail,
          customerPhone: leads[leadIndex].customerPhone,
          customerAddress: leads[leadIndex].customerAddress,
          customerCity: leads[leadIndex].customerCity,
          customerProvince: leads[leadIndex].customerProvince,
          status: leads[leadIndex].status,
          priority: leads[leadIndex].priority,
          estimatedValue: leads[leadIndex].estimatedValue,
          notes: leads[leadIndex].notes,
          lostReason: leads[leadIndex].lostReason,
          assignedAt: leads[leadIndex].assignedAt,
          lastContactAt: DateTime.now(),
          closedAt: leads[leadIndex].closedAt,
          createdAt: leads[leadIndex].createdAt,
          updatedAt: DateTime.now(),
          productName: leads[leadIndex].productName,
          salesName: leads[leadIndex].salesName,
        );
        leads[leadIndex] = updatedLead;
      }

      Get.snackbar(
        'Success',
        'Activity added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add activity',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
