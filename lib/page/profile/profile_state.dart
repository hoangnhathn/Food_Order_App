import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState({
    @Default(0) int cartCount,
    @Default(0) int orderCount,
    @Default(0) int index,
}) = _ProfileState;
}
