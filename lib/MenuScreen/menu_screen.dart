import 'package:canteen_app/MenuScreen/menu_bloc.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

final List<Category> categories = [
  Category('Супы', 'assets/images/categories/soup.png'),
  Category('Гарниры', 'assets/images/categories/garnish.png'),
  Category('Мясные блюда', 'assets/images/categories/meat.png'),
  Category('Салаты', 'assets/images/categories/salad.png'),
  Category('Выпечка', 'assets/images/categories/cake.png'),
  Category('Напитки', 'assets/images/categories/drink.png'),
  Category('Десерты', 'assets/images/categories/cake.png')
];

var size;
double itemHeight;
double itemWidth;

class _MenuScreenState extends State<MenuScreen> {
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
        child: categotiesListWidget(categories),
      ),
    );
  }
}

Widget categotiesListWidget(List<Category> categories) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (1.8 * itemWidth / itemHeight),
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              menuBloc.goToSelectedCategory(context);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromRGBO(166, 192, 133, 1),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      categories[index].image,
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      categories[index].title,
                      style: TextStyle(
                          color: Color.fromRGBO(251, 244, 244, 1),
                          fontSize: 22),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

class Category {
  String title;
  String image;

  Category(String title, String imgSource) {
    this.title = title;
    image = imgSource;
  }
}
