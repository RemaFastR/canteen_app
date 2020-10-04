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

// var size;
// double itemHeight;
// double itemWidth;

BuildContext scaffoldContext;

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // size = MediaQuery.of(context).size;

    // /*24 - notification bar на Android*/
    // itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // itemWidth = size.width / 2;
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
                              productId: products[index].id,
                              title: products[index].title,
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
                  color: titlesColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                        color: cardsColor,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                products[index].image,
                                fit: BoxFit.fill,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      products[index].title,
                                      style: TextStyle(
                                        color: titlesColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                          products[index].cost.toString() + '₽',
                                          style: TextStyle(
                                              color: titlesColor,
                                              fontSize: 17))),
                                ],
                              ),
                            ])),
                  )
                  //ClipRRect(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     child: GridTile(
                  //         footer: Material(
                  //           color: Colors.transparent,
                  //           shape: const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.vertical(
                  //                   bottom: Radius.circular(8))),
                  //           clipBehavior: Clip.antiAlias,
                  //           child: GridTileBar(
                  //             backgroundColor: cardsColor,
                  //             title: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Container(child: Text(products[index].title)),
                  //                 Container(
                  //                     child: Text(
                  //                         products[index].cost.toString())),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         child: Image.asset(
                  //           products[index].image,
                  //           fit: BoxFit.fill,
                  //         )))
                  ),
            );
          }),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, grammar, imgSrc;
  final int productId, cost;

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
      child: Stack(
        children: [
          Container(
            //height: ScreenSize.itemHeight * 1.5,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: ScreenSize.itemHeight / 2,
                  height: ScreenSize.itemHeight / 2,
                  child: Image.asset(imgSrc),
                ),
                Text(
                  description,
                  style: TextStyle(color: productInfoColor, fontSize: 17),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      grammar,
                      style: TextStyle(color: productInfoColor, fontSize: 19),
                    ),
                    Text(
                      cost.toString() + '₽',
                      style:
                          TextStyle(color: orderProductCostColor, fontSize: 19),
                    ),
                  ],
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
                              this.imgSrc, this.cost);
                          _showToast(scaffoldContext);
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
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: orderProductCostColor,
                  child: Icon(Icons.close, color: titlesColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: titlesColor,
        content: Text('Блюдо добавлено в корзину',
            style: TextStyle(
              color: productInfoColor,
            )),
        action: SnackBarAction(
            label: 'Хорошо', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
