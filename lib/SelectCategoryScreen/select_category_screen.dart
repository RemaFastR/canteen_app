import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatefulWidget {
  SelectCategoryScreen({Key key}) : super(key: key);

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

final List<Product> products = [
  Product('Пюре', 'assets/images/categories/soup.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/garnish.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Пюре', 'assets/images/categories/meat.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/salad.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Пюре', 'assets/images/categories/cake.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/drink.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Пюре', 'assets/images/categories/cake.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/drink.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
];

var size;
double itemHeight;
double itemWidth;

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    /*24 - notification bar на Android*/
    itemHeight = (size.height - kToolbarHeight - 24) / 2;
    itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Меню',
          style: TextStyle(color: Color.fromRGBO(64, 55, 55, 1)),
        ),
      ),
      body: Container(
        child: productsListWidget(products),
      ),
    );
  }
}

Widget productsListWidget(List<Product> products) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (1.8 * itemWidth / itemHeight),
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              showGeneralDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionBuilder: (context, a1, a2, widget) {
                    final curvedValue =
                        Curves.easeInOutBack.transform(a1.value) - 1.0;
                    return Transform(
                      transform: Matrix4.translationValues(
                          0.0, curvedValue * 200, 0.0),
                      child: Opacity(
                          opacity: a1.value,
                          child: CustomDialog(
                            description: products[index].description,
                            grammar: products[index].grammar,
                            cost: products[index].cost,
                            imgSrc: products[index].image,
                          )),
                    );
                  },
                  transitionDuration: Duration(milliseconds: 200),
                  barrierDismissible: true,
                  barrierLabel: '',
                  context: context,
                  pageBuilder: (context, animation1, animation2) {});
              //menuBloc.goToSelectedCategory(context);
            },
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black38,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: GridTile(
                        footer: Material(
                          color: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(8))),
                          clipBehavior: Clip.antiAlias,
                          child: GridTileBar(
                            backgroundColor: Color.fromRGBO(166, 192, 133, 1),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(products[index].title),
                                Text(products[index].cost),
                              ],
                            ),
                          ),
                        ),
                        child: productImage(products[index].image)))),
          );
        }),
  );
}

Widget productImage(String imgSrc) {
  return Image.asset(
    imgSrc,
    fit: BoxFit.fill,
  );
}

class CustomDialog extends StatelessWidget {
  final String description, grammar, cost, imgSrc;

  CustomDialog(
      {@required this.description,
      @required this.grammar,
      @required this.cost,
      this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Color.fromRGBO(251, 244, 244, 1),
      child: Container(
        height: 500,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(imgSrc),
            Text(description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(grammar),
                Text(cost),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: itemHeight / 7,
                  width: itemWidth,
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    fillColor: Color.fromRGBO(166, 192, 133, 1),
                    splashColor: Color.fromRGBO(166, 192, 133, 1),
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                          color: Color.fromRGBO(251, 244, 244, 1),
                          fontSize: 24),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class Product {
  String title;
  String image;
  String cost;
  String grammar;
  String description;

  Product(
      String title, String image, int cost, int grammar, String description) {
    this.title = title;
    this.image = image;
    this.cost = cost.toString() + ' ₽';
    this.grammar = grammar.toString() + 'гр';
    this.description = description;
  }
}
