import 'package:canteen_app/MenuScreen/menu_bloc.dart';
import 'package:canteen_app/Models/category.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

final List<Category> _categories = [
  Category(1, 'Супы', 'assets/images/categories/soup.png'),
  Category(2, 'Гарниры', 'assets/images/categories/garnish.png'),
  Category(3, 'Мясные блюда', 'assets/images/categories/meat.png'),
  Category(4, 'Салаты', 'assets/images/categories/salad.png'),
  Category(5, 'Напитки', 'assets/images/categories/drink.png'),
  Category(6, 'Десерты', 'assets/images/categories/cake.png')
];

// var size;
// double itemHeight;
// double itemWidth;

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // size = MediaQuery.of(context).size;

    // /*24 - notification bar на Android*/
    // itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // itemWidth = size.width / 2;
    ScreenSize.size = MediaQuery.of(context).size;
    /*24 - notification bar на Android*/
    ScreenSize.itemHeight = (ScreenSize.size.height - kToolbarHeight - 24) / 2;
    ScreenSize.itemWidth = ScreenSize.size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Меню',
          style: TextStyle(color: productInfoColor),
        ),
      ),
      body: Container(
        child: CategoriesWidget(_categories),
      ),
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  List<Category> categories;

  CategoriesWidget(this.categories);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                (1.8 * ScreenSize.itemWidth / ScreenSize.itemHeight),
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                menuBloc.goToSelectedCategory(context, categories[index].id);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: cardsColor,
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
                        style:
                            const TextStyle(color: titlesColor, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
