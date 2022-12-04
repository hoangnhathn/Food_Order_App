import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_cart_info.freezed.dart';

part 'db_cart_info.g.dart';

@freezed
class DbCartInfo extends DbBaseModel with _$DbCartInfo {
  factory DbCartInfo({
    @JsonKey(name: DbCartInfoFields.foodInfoId) required int foodInfoId,
    @JsonKey(name: DbCartInfoFields.quantity) required int quantity,
    @JsonKey(name: DbCartInfoFields.price) required double price,
    @JsonKey(name: DbCartInfoFields.time) required String time,
    @JsonKey(name: DbCartInfoFields.userInfoId) int? userInfoId,
    @JsonKey(name: DbCartInfoFields.id) int? id,
  }) = _DbCartInfo;

  factory DbCartInfo.fromJson(Map<String, dynamic> json) =>
      _$DbCartInfoFromJson(json);
}
