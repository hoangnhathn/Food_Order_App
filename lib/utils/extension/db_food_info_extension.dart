import '../../data/model/db/db_food_info.dart';

extension DbFoodInfoExtension on DbFoodInfo {
  String get convertCurrency => '$price VND';
}
