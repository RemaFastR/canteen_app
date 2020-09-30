import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/functional/api_provider.dart';

class SelectCategoryRepository {
  ApiProvider apiProvider = ApiProvider();

  //Future<List> getCategories() => apiProvider.getCategories();
  Future<List<Product>> getCategories(int id) async {
    switch (id) {
      case 1:
        {
          return StaticCategories.products1;
        }
        break;
      case 2:
        {
          return StaticCategories.products2;
        }
        break;
      case 3:
        {
          return StaticCategories.products3;
        }
        break;
      case 4:
        {
          return StaticCategories.products4;
        }
        break;
      case 5:
        {
          return StaticCategories.products5;
        }
        break;
      case 6:
        {
          return StaticCategories.products6;
        }
        break;
      case 7:
        {
          return StaticCategories.products7;
        }
        break;
      default:
        {
          print("Empty lists");
        }
        break;
    }
  }
}

class StaticCategories {
  static List<Product> products1 = [
    Product('Борщ', 'assets/images/categories/soup.png', 100, '300',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product(
        'Суп с фрикадельками',
        'assets/images/categories/garnish.png',
        150,
        '300/500/50',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Солянка мясная', 'assets/images/categories/meat.png', 170, '300',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products2 = [
    Product(
        'Куриная котлета',
        'assets/images/categories/soup.png',
        40,
        '120/100/50',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product('Филе куриное', 'assets/images/categories/garnish.png', 65, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Свиная отбивная', 'assets/images/categories/meat.png', 72, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products3 = [
    Product('Рис с овощами', 'assets/images/categories/soup.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product('Греча', 'assets/images/categories/garnish.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Макароны', 'assets/images/categories/meat.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Картофельное пюре', 'assets/images/categories/meat.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products4 = [
    Product('Салат овощной', 'assets/images/categories/soup.png', 150, '270',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product('Винегрет', 'assets/images/categories/garnish.png', 75, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Оливье', 'assets/images/categories/meat.png', 85, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products5 = [
    Product('Чизкейк', 'assets/images/categories/soup.png', 20, '30',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product('Тирамису', 'assets/images/categories/garnish.png', 220, '350',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Шоколадный брауни', 'assets/images/categories/meat.png', 20, '39',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products6 = [
    Product(
        'Пирог с яблочной начинкой ',
        'assets/images/categories/garnish.png',
        60,
        '100',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Сочень с творогом', 'assets/images/categories/meat.png', 45, '100',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products7 = [
    Product('Компот', 'assets/images/categories/garnish.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product('Апельсиновый сок', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Яблочный сок', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Чай черный', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Чай зеленый', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Кофе Эспрессо', 'assets/images/categories/meat.png', 60, '40',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Кофе Капучино', 'assets/images/categories/meat.png', 70, '80',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product('Кофе Американо', 'assets/images/categories/meat.png', 60, '80',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];
}
