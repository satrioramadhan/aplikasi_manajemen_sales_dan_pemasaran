class ProductModel {
  final int id;
  final int companyId;
  final String productCode;
  final String name;
  final String description;
  final String category;
  final double price;
  final double? discountPrice;
  final double commissionPercentage;
  final double commissionFlat;
  final String status; // 'active', 'inactive', 'draft'
  final List<String> images;
  final Map<String, dynamic>? specifications;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.companyId,
    required this.productCode,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.discountPrice,
    this.commissionPercentage = 0,
    this.commissionFlat = 0,
    this.status = 'active',
    this.images = const [],
    this.specifications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      productCode: json['product_code'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: json['discount_price'] != null
          ? (json['discount_price']).toDouble()
          : null,
      commissionPercentage: (json['commission_percentage'] ?? 0).toDouble(),
      commissionFlat: (json['commission_flat'] ?? 0).toDouble(),
      status: json['status'] ?? 'active',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      specifications: json['specifications'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'product_code': productCode,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'discount_price': discountPrice,
      'commission_percentage': commissionPercentage,
      'commission_flat': commissionFlat,
      'status': status,
      'images': images,
      'specifications': specifications,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Get effective price (discount or regular)
  double getEffectivePrice() {
    return discountPrice ?? price;
  }

  // Calculate commission amount
  double getCommissionAmount() {
    final effectivePrice = getEffectivePrice();
    final percentageCommission = effectivePrice * (commissionPercentage / 100);
    return percentageCommission + commissionFlat;
  }

  // Check if product has discount
  bool hasDiscount() {
    return discountPrice != null && discountPrice! < price;
  }

  // Get discount percentage
  double getDiscountPercentage() {
    if (!hasDiscount()) return 0;
    return ((price - discountPrice!) / price) * 100;
  }

  // Get first image or placeholder
  String getMainImage() {
    return images.isNotEmpty ? images.first : '';
  }
}
