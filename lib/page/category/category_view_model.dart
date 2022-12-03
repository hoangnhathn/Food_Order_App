import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dummy/categories.dart';
import 'category_state.dart';

class CategoryViewModel extends StateNotifier<CategoryState> {
  CategoryViewModel() : super(CategoryState.initial());

  void init() {
    state = state.copyWith(
      categories: dummyCategories,
    );
  }
}
