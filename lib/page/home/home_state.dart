import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/db/db_user_info.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required DbUserInfo userInfo,
    @Default(0) int index,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        userInfo: DbUserInfo(
          username: '',
          password: '',
        ),
        index: 0,
      );
}
