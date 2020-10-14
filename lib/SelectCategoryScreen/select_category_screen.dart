import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_bloc.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:flutter/material.dart';

int categoryId;

class SelectCategoryScreen extends StatefulWidget {
  SelectCategoryScreen(int id) {
    categoryId = id;
  }

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

BuildContext scaffoldContext;

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    scaffoldContext = context;
    categoryBloc.getSelectCategory(categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Меню',
          style: TextStyle(color: productInfoColor),
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: categoryBloc.categoryStream,
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                print("Snapshot Size: ${snapshot.data.length}");
                //print(json.encode(snapshot.data));
                return ProductsListWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class ProductsListWidget extends StatelessWidget {
  List<Product> products;
  ProductsListWidget(this.products);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                (1.5 * ScreenSize.itemWidth / (ScreenSize.itemHeight)),
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                double dragStart;
                double dragUpdate;
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
                            child: GestureDetector(
                              onVerticalDragStart: (details) {
                                dragStart =
                                    details.globalPosition.dy.floorToDouble();

                                print('dragStart ' + dragStart.toString());
                              },
                              onVerticalDragUpdate: (details) {
                                dragUpdate =
                                    details.globalPosition.dy.floorToDouble();
                                print('dragUpdate' + dragUpdate.toString());
                                if (dragUpdate + 40 < dragStart) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: CustomDialog(
                                productId: products[index].id,
                                title: products[index].title,
                                description: products[index].description,
                                grammar: products[index].grammar,
                                cost: products[index].cost,
                                imgSrc: products[index].image,
                              ),
                            )),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 500),
                    barrierDismissible: true,
                    barrierLabel: '',
                    context: context,
                    pageBuilder: (context, animation1, animation2) {});
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: titlesColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                        color: cardsColor,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                //width: ScreenSize.itemWidth / 1.3,
                                height: ScreenSize.itemHeight / 3.3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    products[index].image +
                                        '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                products[index].title,
                                style: TextStyle(
                                  color: titlesColor,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    //flex: 2,
                                    child: Text(
                                      products[index].grammar.toString() +
                                          ' гр.',
                                      style: TextStyle(
                                        color: titlesColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      //flex: 1,
                                      child: Text(
                                          products[index]
                                                  .cost
                                                  .toStringAsFixed(2) +
                                              '₽',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: titlesColor,
                                              fontSize: 17))),
                                ],
                              ),
                            ])),
                  )),
            );
          }),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, imgSrc;
  final int productId, grammar;
  final double cost;

  CustomDialog(
      {@required this.productId,
      @required this.description,
      @required this.grammar,
      @required this.cost,
      this.imgSrc,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: titlesColor,
        child: dialog(context));
  }

  Widget dialog(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: [
          Container(
            //height: ScreenSize.itemHeight * 1.5,
            padding: EdgeInsets.only(top: 10.0, bottom: 10),
            //margin: EdgeInsets.all(13),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    //width: ScreenSize.itemHeight / 1.5,
                    padding: EdgeInsets.all(10),
                    height: ScreenSize.itemHeight / 2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(imgSrc +
                            '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: TextStyle(color: productInfoColor, fontSize: 17),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            grammar.toString() + ' гр.',
                            style: TextStyle(
                                color: productInfoColor, fontSize: 19),
                          ),
                          Text(
                            cost.toStringAsFixed(2) + '₽',
                            style: TextStyle(
                                color: orderProductCostColor, fontSize: 19),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: ScreenSize.itemHeight / 7,
                      width: ScreenSize.itemWidth,
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        fillColor: cardsColor,
                        splashColor: cardsColor,
                        onPressed: () {
                          categoryBloc.addInOrder(this.productId, this.title,
                              this.imgSrc, this.cost, scaffoldContext);
                          Navigator.of(context).pop(); // To close the dialog
                        },
                        child: Text(
                          'Добавить',
                          style: TextStyle(color: titlesColor, fontSize: 24),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          // Positioned(
          //   right: 0.0,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Align(
          //       alignment: Alignment.topRight,
          //       child: CircleAvatar(
          //         radius: 14.0,
          //         backgroundColor: orderProductCostColor,
          //         child: Icon(Icons.close, color: titlesColor),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
