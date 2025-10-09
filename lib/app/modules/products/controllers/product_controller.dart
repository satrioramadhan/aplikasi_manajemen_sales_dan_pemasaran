import 'package:get/get.dart';
import '../../../data/models/product_model.dart';

class ProductController extends GetxController {
  // Observable Variables
  final isLoading = false.obs;
  final products = <ProductModel>[].obs;
  final filteredProducts = <ProductModel>[].obs;
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;

  // Categories
  final categories = <String>[
    'All',
    'Electronics',
    'Fashion',
    'Food & Beverage',
    'Health & Beauty',
    'Home & Living',
    'Services',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  // Load Products (Mock)
  Future<void> loadProducts() async {
    try {
      isLoading.value = true;

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Products Data
      products.value = [
        ProductModel(
          id: 1,
          companyId: 1,
          productCode: 'PROD-001',
          name: 'Premium Laptop Dell XPS 15',
          description:
              'Laptop high-end dengan processor Intel Core i7 Gen 12, RAM 16GB, SSD 512GB, Display 15.6" 4K OLED, dan NVIDIA RTX 3050 Ti. Cocok untuk profesional dan content creator.',
          category: 'Electronics',
          price: 25000000,
          discountPrice: 22500000,
          commissionPercentage: 5,
          commissionFlat: 250000,
          status: 'active',
          images: [
            'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=800',
            'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=800',
          ],
          specifications: {
            'Processor': 'Intel Core i7-12700H',
            'RAM': '16GB DDR5',
            'Storage': '512GB NVMe SSD',
            'Display': '15.6" 4K OLED',
            'Graphics': 'NVIDIA RTX 3050 Ti',
            'Weight': '1.8 kg',
          },
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 2,
          companyId: 1,
          productCode: 'PROD-002',
          name: 'Smartphone Samsung Galaxy S23',
          description:
              'Flagship smartphone dengan kamera 50MP, layar AMOLED 6.1", processor Snapdragon 8 Gen 2, dan baterai 3900mAh dengan fast charging.',
          category: 'Electronics',
          price: 12000000,
          commissionPercentage: 8,
          commissionFlat: 0,
          status: 'active',
          images: [
            'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=800',
          ],
          specifications: {
            'Display': '6.1" Dynamic AMOLED 2X',
            'Processor': 'Snapdragon 8 Gen 2',
            'RAM': '8GB',
            'Storage': '256GB',
            'Camera': '50MP + 12MP + 10MP',
            'Battery': '3900mAh',
          },
          createdAt: DateTime.now().subtract(const Duration(days: 25)),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 3,
          companyId: 1,
          productCode: 'PROD-003',
          name: 'Wireless Headphone Sony WH-1000XM5',
          description:
              'Premium noise-cancelling headphone dengan audio berkualitas tinggi, baterai 30 jam, dan kenyamanan maksimal untuk penggunaan jangka panjang.',
          category: 'Electronics',
          price: 5500000,
          discountPrice: 4950000,
          commissionPercentage: 10,
          commissionFlat: 100000,
          status: 'active',
          images: [
            'https://images.unsplash.com/photo-1545127398-14699f92334b?w=800',
          ],
          specifications: {
            'Type': 'Over-ear',
            'Connectivity': 'Bluetooth 5.2',
            'Battery Life': '30 hours',
            'Noise Cancelling': 'Active (ANC)',
            'Weight': '250g',
          },
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 4,
          companyId: 1,
          productCode: 'PROD-004',
          name: 'Smart Watch Apple Watch Series 8',
          description:
              'Smartwatch dengan health monitoring lengkap, GPS, water resistant, dan ekosistem Apple yang terintegrasi.',
          category: 'Electronics',
          price: 7500000,
          commissionPercentage: 6,
          commissionFlat: 150000,
          status: 'active',
          images: [
            'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=800',
          ],
          specifications: {
            'Display': '1.9" Retina LTPO OLED',
            'Processor': 'Apple S8',
            'Storage': '32GB',
            'Battery Life': '18 hours',
            'Water Resistance': '50m',
          },
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 5,
          companyId: 1,
          productCode: 'PROD-005',
          name: 'Premium Coffee Subscription',
          description:
              'Langganan kopi premium bulanan dengan berbagai varian single origin dari berbagai daerah di Indonesia. Dikirim fresh setiap bulan.',
          category: 'Food & Beverage',
          price: 350000,
          discountPrice: 299000,
          commissionPercentage: 15,
          commissionFlat: 0,
          status: 'active',
          images: [
            'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800',
          ],
          specifications: {
            'Weight': '500g per month',
            'Type': 'Single Origin',
            'Roast Level': 'Medium',
            'Delivery': 'Monthly',
          },
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          updatedAt: DateTime.now(),
        ),
        ProductModel(
          id: 6,
          companyId: 1,
          productCode: 'PROD-006',
          name: 'Digital Marketing Package',
          description:
              'Paket digital marketing lengkap untuk UMKM mencakup social media management, content creation, dan ads management selama 3 bulan.',
          category: 'Services',
          price: 15000000,
          commissionPercentage: 20,
          commissionFlat: 500000,
          status: 'active',
          images: [
            'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800',
          ],
          specifications: {
            'Duration': '3 months',
            'Platforms': 'Instagram, Facebook, TikTok',
            'Posts': '20 posts per month',
            'Ads Budget': 'Rp 2,000,000 per month',
          },
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now(),
        ),
      ];

      filteredProducts.value = products;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Search Products
  void searchProducts(String query) {
    searchQuery.value = query;
    _filterProducts();
  }

  // Filter by Category
  void filterByCategory(String category) {
    selectedCategory.value = category;
    _filterProducts();
  }

  // Apply Filters
  void _filterProducts() {
    var result = products.toList();

    // Filter by category
    if (selectedCategory.value != 'All') {
      result = result
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      result = result.where((product) {
        final query = searchQuery.value.toLowerCase();
        return product.name.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query) ||
            product.productCode.toLowerCase().contains(query);
      }).toList();
    }

    filteredProducts.value = result;
  }

  // Refresh Products
  Future<void> refreshProducts() async {
    await loadProducts();
  }

  // Get Product by ID
  ProductModel? getProductById(int id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
