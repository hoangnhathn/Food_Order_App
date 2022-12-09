import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/search_list/search_list_repository.dart';
import 'model/search_condition_type.dart';
import 'model/search_list_arguments.dart';
import 'search_list_state.dart';

class SearchListViewModel extends StateNotifier<SearchListState> {
  SearchListViewModel({
    required this.searchListRepository,
    required this.reader,
  }) : super(SearchListState());

  final SearchListRepository searchListRepository;

  Ref reader;

  Future<void> init(SearchListArguments arguments) async {
    state = state.copyWith(
      searchConditionType: arguments.searchConditionType,
    );
    switch (arguments.searchConditionType) {
      case SearchConditionType.viewAllFood:
        final foodItems = await searchListRepository.getAllDbFoodInfo();
        state = state.copyWith(foods: foodItems);
        break;
      case SearchConditionType.viewAllShop:
        final shopItems = await searchListRepository.getAllDbShopInfo();
        state = state.copyWith(shops: shopItems);
        break;
      case SearchConditionType.viewByCategory:
        final foodItems = await searchListRepository.getFoodByCategory(
          arguments.categoryId ?? 1,
        );
        state = state.copyWith(foods: foodItems);
        break;
      case SearchConditionType.viewSearchInput:
        final shopItems = await searchListRepository.getAllDbShopInfo();
        final foodItems = await searchListRepository.getAllDbFoodInfo();

        state = state.copyWith(
          foods: foodItems,
          shops: shopItems,
          originalFoods: foodItems,
          originalShops: shopItems,
        );
        break;
    }
  }

  bool showSearchInput() {
    return state.searchConditionType == SearchConditionType.viewSearchInput;
  }

  void searchInput(String search) {
    final foodFilterItems = state.originalFoods
        .where(
          (food) => food.title.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
    final shopFilterItems = state.originalShops
        .where(
          (shop) =>
              shop.title.toLowerCase().contains(search.toLowerCase()) ||
              shop.name.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();

    state = state.copyWith(
      foods: foodFilterItems,
      shops: shopFilterItems,
    );
  }
}
