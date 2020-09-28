import 'package:canteen_app/TabbedScreen/tabbed_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
