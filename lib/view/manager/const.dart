import 'package:easy_localization/easy_localization.dart';
import 'package:restaurant_managment/translations/locale_keys.g.dart';

import '../../model/models.dart';
import '../resourse/assets_manager.dart';

class ConstApp {
  static Map<String, dynamic> images = {
    "0": [AssetsManager.drinksIMG, tr(LocaleKeys.drink)],
    "1": [AssetsManager.mainDishesIMG, tr(LocaleKeys.main_dishes)],
    "2": [AssetsManager.appetizerIMG, tr(LocaleKeys.appetizer)],
    "3": [AssetsManager.saladIMG, tr(LocaleKeys.salad)],
  };

  static List<Meal> meals = [
    Meal(
      name: 'FRIED KIBBEH',
      price: '46.00',
      ingredients: [
        'Finely' 'ground bulgur',
        'stuffed onion',
        'lamb and beef',
        'labneh and spicy tomato sauce'
      ],
    ),
    Meal(
      name: 'BATATA HARRA',
      price: '55.00',
      ingredients: [
        'Fried Potatoes',
        'Tossed With Garlic And Flavorful',
        'Herbs And Spices',
        'PASTA & CHEESE BALLS'
      ],
    ),
    Meal(
      name: 'FRIED KIBBEH',
      price: '46.00',
      ingredients: [
        'Finely' 'ground bulgur',
        'stuffed onion',
        'lamb and beef',
        'labneh and spicy tomato sauce'
      ],
    ),
    Meal(
      name: 'BATATA HARRA',
      price: '55.00',
      ingredients: [
        'Fried Potatoes',
        'Tossed With Garlic And Flavorful',
        'Herbs And Spices',
        'PASTA & CHEESE BALLS'
      ],
    ),
    Meal(
      name: 'FRIED KIBBEH',
      price: '46.00',
      ingredients: [
        'Finely' 'ground bulgur',
        'stuffed onion',
        'lamb and beef',
        'labneh and spicy tomato sauce'
      ],
    ),
    Meal(
      name: 'BATATA HARRA',
      price: '55.00',
      ingredients: [
        'Fried Potatoes',
        'Tossed With Garlic And Flavorful',
        'Herbs And Spices',
        'PASTA & CHEESE BALLS'
      ],
    ),
    Meal(
      name: 'FRIED KIBBEH',
      price: '46.00',
      ingredients: [
        'Finely' 'ground bulgur',
        'stuffed onion',
        'lamb and beef',
        'labneh and spicy tomato sauce'
      ],
    ),
    Meal(
      name: 'BATATA HARRA',
      price: '55.00',
      ingredients: [
        'Fried Potatoes',
        'Tossed With Garlic And Flavorful',
        'Herbs And Spices',
        'PASTA & CHEESE BALLS'
      ],
    ),
    Meal(
      name: 'FRIED KIBBEH',
      price: '46.00',
      ingredients: [
        'Finely' 'ground bulgur',
        'stuffed onion',
        'lamb and beef',
        'labneh and spicy tomato sauce'
      ],
    ),
    Meal(
      name: 'BATATA HARRA',
      price: '55.00',
      ingredients: [
        'Fried Potatoes',
        'Tossed With Garlic And Flavorful',
        'Herbs And Spices',
        'PASTA & CHEESE BALLS'
      ],
    ),
    Meal(
      name: 'FRIED KIBBEH',
      price: '46.00',
      ingredients: [
        'Finely' 'ground bulgur',
        'stuffed onion',
        'lamb and beef',
        'labneh and spicy tomato sauce'
      ],
    ),
  ];
}
