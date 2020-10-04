class Product {
  int id;
  String title;
  String image;
  int cost;
  String grammar;
  String description;

  Product(int id, String title, String image, int cost, String grammar,
      String description) {
    this.id = id;
    this.title = title;
    this.image = image;
    this.cost = cost;
    this.grammar = grammar.toString() + 'гр';
    this.description = description;
  }
}
