import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/db_tables.dart';
import '../db_base_model.dart';

part 'db_user_info.freezed.dart';

part 'db_user_info.g.dart';

@freezed
class DbUserInfo extends DbBaseModel with _$DbUserInfo {
  factory DbUserInfo({
    @JsonKey(name: DbUserInfoFields.username) required String username,
    @JsonKey(name: DbUserInfoFields.password) required String password,
    @JsonKey(name: DbUserInfoFields.id) int? id,
  }) = _DbUserInfo;

  factory DbUserInfo.fromJson(Map<String, dynamic> json) =>
      _$DbUserInfoFromJson(json);
}
