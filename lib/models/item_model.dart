class Item {
  late double quantity;
  late String barcode;
  late String itemId;
  late double price;
  late String name;

  Item({
    required this.quantity,
    required this.barcode,
    required this.itemId,
    required this.price,
    required this.name,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      quantity: json['quantity'],
      barcode: json['barcode'],
      itemId: json['itemId'],
      price: json['price'],
      name: json['name'],
    );
  }
}
