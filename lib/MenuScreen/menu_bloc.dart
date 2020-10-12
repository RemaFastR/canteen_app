import 'dart:convert';

import 'package:canteen_app/MenuScreen/menu_repos.dart';
import 'package:canteen_app/Models/category.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_screen.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/functional/main_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc implements Bloc {
  CategoryRepository _categoryRepository = CategoryRepository();

  Future<void> goToSelectedCategory(BuildContext context, int id) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectCategoryScreen(id)));
  }

  final _categoryFetcher = PublishSubject<List<Category>>();
  Observable<List<Category>> get categoryStream => _categoryFetcher.stream;

  getCategories() async {
    List<Category> categories = await _categoryRepository.getCategories();
    StaticVariables.staticCategories = categories;
    //print(jsonEncode(categories));
    _categoryFetcher.sink.add(categories);
  }

  @override
  void dispose() {
    _categoryFetcher.close();
  }
}

final menuBloc = MenuBloc();
