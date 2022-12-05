import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_shop_info.g.dart';

part 'db_shop_info.freezed.dart';

@freezed
class DbShopInfo extends DbBaseModel with _$DbShopInfo {
  factory DbShopInfo({
    @JsonKey(name: DbShopInfoFields.name) required String name,
    @JsonKey(name: DbShopInfoFields.title) required String title,
    @JsonKey(name: DbShopInfoFields.banner) required String banner,
    @JsonKey(name: DbShopInfoFields.comment) required int comment,
    @JsonKey(name: DbShopInfoFields.time) required int time,
    @JsonKey(name: DbShopInfoFields.rating) required double rating,
    @JsonKey(name: DbShopInfoFields.distance) required int distance,
    @JsonKey(name: DbFoodInfoFields.id) int? id,
  }) = _DbShopInfo;

  factory DbShopInfo.fromJson(Map<String, dynamic> json) =>
      _$DbShopInfoFromJson(json);
}
