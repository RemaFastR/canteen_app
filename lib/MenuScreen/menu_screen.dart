import 'package:canteen_app/MenuScreen/menu_bloc.dart';
import 'package:canteen_app/Models/category.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/functional/check_internet_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);
  static BuildContext menuScreenContext;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    MenuScreen.menuScreenContext = context;
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
      body: StreamProvider<NetworkStatus>(
        create: (context) =>
            NetworkStatusService().networkStatusController.stream,
        child: NetworkAwareWidget(
          onlineChild: Container(
            child: StreamBuilder(
              stream: menuBloc.categoryStream,
              builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  print("Categories Snapshot Size: ${snapshot.data.length}");
                  return CategoriesWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          offlineChild: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.outlet,
                  size: 50,
                  color: productInfoColor,
                ),
                Text(
                  "Проверьте подключение к интернету!",
                  style: TextStyle(
                      color: productInfoColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                ),
              ],
            ),
          ),
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
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.5),
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                menuBloc.goToSelectedCategory(context, categories[index].id);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: cardsColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        //width: ScreenSize.itemWidth / 1.3,
                        //height: ScreenSize.itemHeight / 3.3,
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            categories[index].products[0].image +
                                '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        categories[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: titlesColor,
                          fontSize: 22,
                        ),
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
