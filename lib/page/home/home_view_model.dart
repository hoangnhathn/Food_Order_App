import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/provider/cart_provider.dart';
import '../../data/repository/home/home_repository.dart';
import '../../data/repository/user_repository/user_repository.dart';
import '../../dummy/banner.dart';
import '../../dummy/categories.dart';
import 'home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required this.homeRepository,
    required this.userRepository,
    required this.reader,
  }) : super(HomeState.initial());

  final HomeRepository homeRepository;
  final UserRepository userRepository;
  Ref reader;

  Future<void> init() async {
    /// Init Cart
    await reader.read(cartProvider.notifier).init();

    final shopItemInfo = await homeRepository.getAllShopItems();

    final foodItemInfo = await homeRepository.getAllFoodItems();

    final userInfo = await userRepository.getCurrentUser();
    state = state.copyWith(
      userInfo: userInfo!,
      categories: dummyCategories,
      banners: dummyBanners,
      populars: shopItemInfo,
      recommends: foodItemInfo,
    );
  }
}
