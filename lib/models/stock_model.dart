class Stock {
  late int documentNum;
  late double quantity;
  late String itemId;
  late String time;

  Stock({
    required this.documentNum,
    required this.quantity,
    required this.itemId,
    required this.time,
  });
  Stock.fromJson(Map<String, dynamic> json) {
    documentNum = json['documentNum'];
    quantity = json['quantity'];
    itemId = json['itemId'];
    time = json['time'];
  }
}
