import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  factory CategoryState({
    @Default(0) int index,
  }) = _CategoryState;

  factory CategoryState.initial() => CategoryState(
        index: 0,
      );
}
