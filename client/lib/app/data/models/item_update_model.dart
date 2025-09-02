class ItemUpdateModel {
  final String? itemsName;
  final int? categoryId;
  final int? stocks;
  final String? itemsGroup;
  final double? price;

  ItemUpdateModel({
    this.itemsName,
    this.categoryId,
    this.stocks,
    this.itemsGroup,
    this.price,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (itemsName != null) {
      data['itemsName'] = itemsName;
    }
    if (categoryId != null) {
      data['categoryId'] = categoryId;
    }
    if (stocks != null) {
      data['stocks'] = stocks;
    }
    if (itemsGroup != null) {
      data['itemsGroup'] = itemsGroup;
    }
    if (price != null) {
      data['price'] = price;
    }

    return data;
  }
}
