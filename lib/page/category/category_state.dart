import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/category/category_food.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  factory CategoryState({
    required List<CategoryFood> categories,
    @Default(0) int index,
  }) = _CategoryState;

  factory CategoryState.initial() => CategoryState(
        categories: [],
        index: 0,
      );
}
