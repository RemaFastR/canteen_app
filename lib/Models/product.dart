class Product {
  String title;
  String image;
  String cost;
  String grammar;
  String description;

  Product(String title, String image, int cost, String grammar,
      String description) {
    this.title = title;
    this.image = image;
    this.cost = cost.toString() + ' ₽';
    this.grammar = grammar.toString() + 'гр';
    this.description = description;
  }
}
