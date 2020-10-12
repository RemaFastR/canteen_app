import 'package:canteen_app/MenuScreen/menu_bloc.dart';
import 'package:canteen_app/Models/category.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_bloc.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

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
    menuBloc.getCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Меню',
          style: TextStyle(color: productInfoColor),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: menuBloc.categoryStream,
          builder: (context, AsyncSnapshot<List<Category>> snapshot) {
            if (snapshot.hasData) {
              print("Categories Snapshot Size: ${snapshot.data.length}");
              //print(json.encode(snapshot.data));
              return CategoriesWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Image.asset(
                      //   'assets/images/categories/soup.png',
                      //   width: 150,
                      //   height: 150,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                          categories[index].products[0].image +
                              '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf',
                          width: 150,
                          height: 150,
                        ),
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
