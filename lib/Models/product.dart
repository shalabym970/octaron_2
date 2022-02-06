class Product {
  Product({
    required this.id,
    required this.name,
    required this.userId,
    required this.cartId,
    required this.category,
    required this.productdesc,
    required this.price,
    this.slug,
    required this.image,
    required this.brand,
    required this.brandId,
    required this.qnt,
    this.model,
    this.keywords,
    required this.priceDiscount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int userId;
  int cartId;
  String category;
  String productdesc;
  int price;
  dynamic slug;
  String image;
  String brand;
  int brandId;
  int qnt;
  dynamic model;
  dynamic keywords;
  int priceDiscount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        cartId: json["cart_id"],
        category: json["category"],
        productdesc: json["productdesc"],
        price: json["price"],
        slug: json["slug"] ?? "",
        image: json["image_url"] ?? "",
        brand: json["brand"] ?? "",
        brandId: json["brand_id"],
        qnt: json["qnt"],
        model: json["model"],
        keywords: json["keywords"],
        priceDiscount: json["price_discount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  static fromJsonList(List<dynamic> products) {
    return products.map((product) => Product.fromJson(product)).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "cart_id": cartId,
        "category": category,
        "productdesc": productdesc,
        "price": price,
        "slug": slug,
        "image": image,
        "brand": brand,
        "brand_id": brandId,
        "qnt": qnt,
        "model": model,
        "keywords": keywords,
        "price_discount": priceDiscount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
