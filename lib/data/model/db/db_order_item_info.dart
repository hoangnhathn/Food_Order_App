import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_order_item_info.freezed.dart';
part 'db_order_item_info.g.dart';

@freezed
class DbOrderItemInfo extends DbBaseModel with _$DbOrderItemInfo {
  factory DbOrderItemInfo({
    @JsonKey(name: DbOrderItemInfoFields.title) required String title,
    @JsonKey(name: DbOrderItemInfoFields.price) required double price,
    @JsonKey(name: DbOrderItemInfoFields.quantity) required int quantity,
    @JsonKey(name: DbOrderItemInfoFields.banner) required String banner,
    @JsonKey(name: DbOrderItemInfoFields.foodInfoId) required int foodInfoId,
    @JsonKey(name: DbOrderItemInfoFields.orderInfoId) required int orderInfoId,
    @JsonKey(name: DbOrderItemInfoFields.id) int? id,
  }) = _DbOrderItemInfo;

  factory DbOrderItemInfo.fromJson(Map<String, dynamic> json) =>
      _$DbOrderItemInfoFromJson(json);
}
