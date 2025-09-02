class CategoryModel {
  final int id;
  final String categoryName;

  CategoryModel({
    required this.id,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
      };
}
