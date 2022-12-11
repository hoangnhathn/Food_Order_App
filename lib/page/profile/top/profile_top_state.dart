import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_top_state.freezed.dart';

@freezed
class ProfileTopState with _$ProfileTopState {
  factory ProfileTopState({
    @Default('') String name,
    @Default(0) int cartCount,
    @Default(0) int orderCount,
    @Default(0) int index,
}) = _ProfileTopState;
}
