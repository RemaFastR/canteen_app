import 'dart:io';

import 'package:canteen_app/TabbedScreen/tabbed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Models/order.dart';
import 'functional/attributes.dart';
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

final List<ProductForOrder> orderProductsList = List<ProductForOrder>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Фоновый цвет для всех окон.
        scaffoldBackgroundColor: titlesColor,
        // Стандартный цвет для виджетов.
        accentColor: Color.fromRGBO(231, 181, 127, 1),
        // Цвет фона для основых частей приложения (toolbars, tab bars и т.д.).
        primaryColor: Color.fromRGBO(231, 181, 127, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabbedScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
