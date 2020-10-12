class ReturnedOrder {
  int id;
  int currentState;
  List<Segment> segments;

  ReturnedOrder({
    this.id,
    this.currentState,
    this.segments,
  });

  factory ReturnedOrder.fromJson(Map<String, dynamic> json) {
    var list = json["segments"] as List;
    List<Segment> segmentList = list.map((i) => Segment.fromJson(i)).toList();
    return ReturnedOrder(
        id: json["id"],
        currentState: json["currentState"],
        segments: segmentList);
  }
}

class Segment {
  int id;
  int productId;
  int quantity;

  Segment({
    this.id,
    this.productId,
    this.quantity,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
        id: json["id"],
        productId: json["productId"],
        quantity: json["quantity"]);
  }
}
