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
    Product(1, 'Борщ', 'assets/images/categories/soup.png', 100, '300',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product(
        2,
        'Суп с фрикадельками',
        'assets/images/categories/garnish.png',
        150,
        '300/500/50',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(
        3,
        'Солянка мясная',
        'assets/images/categories/meat.png',
        170,
        '300',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products2 = [
    Product(
        4,
        'Куриная котлета',
        'assets/images/categories/soup.png',
        40,
        '120/100/50',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product(
        5,
        'Филе куриное',
        'assets/images/categories/garnish.png',
        65,
        '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(
        6,
        'Свиная отбивная',
        'assets/images/categories/meat.png',
        72,
        '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products3 = [
    Product(7, 'Рис с овощами', 'assets/images/categories/soup.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product(8, 'Греча', 'assets/images/categories/garnish.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(9, 'Макароны', 'assets/images/categories/meat.png', 45, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(
        10,
        'Картофельное пюре',
        'assets/images/categories/meat.png',
        45,
        '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products4 = [
    Product(
        11,
        'Салат овощной',
        'assets/images/categories/soup.png',
        150,
        '270',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product(12, 'Винегрет', 'assets/images/categories/garnish.png', 75, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(13, 'Оливье', 'assets/images/categories/meat.png', 85, '150',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products5 = [
    Product(14, 'Чизкейк', 'assets/images/categories/soup.png', 20, '30',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '),
    Product(15, 'Тирамису', 'assets/images/categories/garnish.png', 220, '350',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(
        16,
        'Шоколадный брауни',
        'assets/images/categories/meat.png',
        20,
        '39',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products6 = [
    Product(
        17,
        'Пирог с яблочной начинкой ',
        'assets/images/categories/garnish.png',
        60,
        '100',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(
        18,
        'Сочень с творогом',
        'assets/images/categories/meat.png',
        45,
        '100',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];

  static List<Product> products7 = [
    Product(19, 'Компот', 'assets/images/categories/garnish.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
    Product(
        20,
        'Апельсиновый сок',
        'assets/images/categories/meat.png',
        30,
        '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(21, 'Яблочный сок', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(22, 'Чай черный', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(23, 'Чай зеленый', 'assets/images/categories/meat.png', 30, '200',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(24, 'Кофе Эспрессо', 'assets/images/categories/meat.png', 60, '40',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(25, 'Кофе Капучино', 'assets/images/categories/meat.png', 70, '80',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
    Product(26, 'Кофе Американо', 'assets/images/categories/meat.png', 60, '80',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'),
  ];
}
