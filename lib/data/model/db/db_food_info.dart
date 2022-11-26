import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_food_info.g.dart';

part 'db_food_info.freezed.dart';

@freezed
class DbFoodInfo extends DbBaseModel with _$DbFoodInfo {
  factory DbFoodInfo({
    @JsonKey(name: DbFoodInfoFields.title) required String title,
    @JsonKey(name: DbFoodInfoFields.subTitle) required String subTitle,
    @JsonKey(name: DbFoodInfoFields.banner) required String banner,
    @JsonKey(name: DbFoodInfoFields.price) required double price,
    @JsonKey(name: DbFoodInfoFields.time) required int time,
    @JsonKey(name: DbFoodInfoFields.distance) required int distance,
    @JsonKey(name: DbFoodInfoFields.id) int? id,
    @Default(4) int rating,
  }) = _DbFoodInfo;

  factory DbFoodInfo.fromJson(Map<String, dynamic> json) =>
      _$DbFoodInfoFromJson(json);
}
