import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_food_info.freezed.dart';

part 'db_food_info.g.dart';

@freezed
class DbFoodInfo extends DbBaseModel with _$DbFoodInfo {
  factory DbFoodInfo({
    @JsonKey(name: DbFoodInfoFields.shopInfoId) required int shopInfoId,
    @JsonKey(name: DbFoodInfoFields.title) required String title,
    @JsonKey(name: DbFoodInfoFields.banner) required String banner,
    @JsonKey(name: DbFoodInfoFields.price) required double price,
    @JsonKey(name: DbFoodInfoFields.category) required int category,
    @JsonKey(name: DbFoodInfoFields.sold) required int sold,
    @JsonKey(name: DbFoodInfoFields.favorite) required int favorite,
    @JsonKey(name: DbFoodInfoFields.id) int? id,
  }) = _DbFoodInfo;

  factory DbFoodInfo.fromJson(Map<String, dynamic> json) =>
      _$DbFoodInfoFromJson(json);
}
