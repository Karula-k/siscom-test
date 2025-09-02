class ItemModel {
  final int id;
  final String itemsName;
  final int categoryId;
  final int stocks;
  final String itemsGroup;
  final double price;

  ItemModel({
    required this.id,
    required this.itemsName,
    required this.categoryId,
    required this.stocks,
    required this.itemsGroup,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        itemsName: json["itemsName"],
        categoryId: json["categoryId"],
        stocks: json["stocks"],
        itemsGroup: json["itemsGroup"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemsName": itemsName,
        "categoryId": categoryId,
        "stocks": stocks,
        "itemsGroup": itemsGroup,
        "price": price,
      };
}
