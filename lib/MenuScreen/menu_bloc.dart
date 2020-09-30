import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_screen.dart';
import 'package:canteen_app/functional/main_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuBloc implements Bloc {
  Future<void> goToSelectedCategory(BuildContext context, int id) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectCategoryScreen(id)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

final menuBloc = MenuBloc();
