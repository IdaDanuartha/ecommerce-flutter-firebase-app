class PromotionModel {
  late String productId;
  late String name;

  PromotionModel({
    required this.name,
    required this.productId,
  });

  PromotionModel.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "name": name,
    };
  }
}