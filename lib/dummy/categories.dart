import '../data/model/category/category_food.dart';
import '../gen/assets.gen.dart';

final dummyCategories = [
  CategoryFood(
    title: 'Đồ ăn',
    places: 2215,
    logoPath: Assets.images.icCategoryFood.path,
  ),
  CategoryFood(
    title: 'Rau',
    places: 432,
    logoPath: Assets.images.icCategoryVegetable.path,
  ),
  CategoryFood(
    title: 'Burger',
    places: 843,
    logoPath: Assets.images.icCategoryBurger.path,
  ),
  CategoryFood(
    title: 'Bánh ngọt',
    places: 124,
    logoPath: Assets.images.icCategoryCake.path,
  ),
  CategoryFood(
    title: 'Phở',
    places: 215,
    logoPath: Assets.images.icCategoryNoodle.path,
  )
];
