import 'package:canteen_app/MenuScreen/menu_screen.dart';
import 'package:canteen_app/OrderScreen/order_screen.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabbedScreen extends StatefulWidget {
  TabbedScreen({Key key}) : super(key: key);

  @override
  _TabbedScreenState createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_buildOffstageNavigator(0), _buildOffstageNavigator(1)],
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).accentColor,
        ),
        child: CurvedNavigationBar(
            animationDuration: const Duration(milliseconds: 400),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            buttonBackgroundColor: Color.fromRGBO(231, 181, 127, 1),
            color: Color.fromRGBO(231, 181, 127, 1),
            height: 50,
            //currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            //type: BottomNavigationBarType.shifting,
            items: [
              //BottomNavigationBarItem(
              //icon:
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              // title: Text(
              //   'Меню',
              //   style: TextStyle(color: Colors.white),
              // )),
              // BottomNavigationBarItem(
              //     icon:
              Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
              // title: Text(
              //   'Корзина',
              //   style: TextStyle(color: Colors.white),
              // )),
            ]),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [MenuScreen(), OrderScreen()].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
