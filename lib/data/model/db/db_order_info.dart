import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_order_info.g.dart';

part 'db_order_info.freezed.dart';

@freezed
class DbOrderInfo extends DbBaseModel with _$DbOrderInfo {
  factory DbOrderInfo({
    @JsonKey(name: DbOrderInfoFields.userInfoId) required int userInfoId,
    @JsonKey(name: DbOrderInfoFields.shopInfoId) required int shopInfoId,
    @JsonKey(name: DbOrderInfoFields.time) required String time,
    @JsonKey(name: DbOrderInfoFields.id) int? id,
  }) = _DbOrderInfo;

  factory DbOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$DbOrderInfoFromJson(json);
}
