import 'package:flutter/material.dart';

import '../data/model/category/category_food.dart';
import '../gen/assets.gen.dart';

final dummyCategories = [
  CategoryFood(
    id: 1,
    title: 'Đồ ăn',
    places: 2215,
    logoPath: Assets.images.icCategoryFood.path,
    color: Colors.red,
  ),
  CategoryFood(
    id: 2,
    title: 'Đồ uống',
    places: 432,
    logoPath: Assets.images.icCategoryDrink.path,
    color: Colors.teal,
  ),
  CategoryFood(
    id: 3,
    title: 'Rau củ',
    places: 432,
    logoPath: Assets.images.icCategoryVegetable.path,
    color: Colors.blueAccent,
  ),
  CategoryFood(
    id: 4,
    title: 'Burger',
    places: 843,
    logoPath: Assets.images.icCategoryBurger.path,
    color: Colors.tealAccent,
  ),
  CategoryFood(
    id: 5,
    title: 'Bánh ngọt',
    places: 124,
    logoPath: Assets.images.icCategoryCake.path,
    color: Colors.amberAccent,
  ),
  CategoryFood(
    id: 6,
    title: 'Phở',
    places: 215,
    logoPath: Assets.images.icCategoryNoodle.path,
    color: Colors.deepOrange,
  ),
  CategoryFood(
    id: 7,
    title: 'Đồ chay',
    places: 215,
    logoPath: Assets.images.icCategoryVegetarianFood.path,
    color: Colors.deepPurpleAccent,
  ),
  CategoryFood(
    id: 8,
    title: 'Cơm hộp',
    places: 215,
    logoPath: Assets.images.icCategoryRice.path,
    color: Colors.greenAccent,
  )
];
