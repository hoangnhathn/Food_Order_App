import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/profile/profile_repository.dart';
import 'profile_top_state.dart';

class ProfileViewModel extends StateNotifier<ProfileTopState> {
  ProfileViewModel({
    required this.profileRepository,
    required this.reader,
  }) : super(ProfileTopState());

  ProfileRepository profileRepository;

  Ref reader;

  Future<void> init() async {
    final name = await profileRepository.getName();
    final cartCount = await profileRepository.getCartCount();
    final orderCount = await profileRepository.getOrderCount();

    state = state.copyWith(
      name: name,
      cartCount: cartCount,
      orderCount: orderCount,
    );
  }

  Future<void> changeName(String value) async {
    if (value.trim().isEmpty) {
      return;
    }
    await profileRepository.changeName(value);
    state = state.copyWith(
      name: value,
    );
  }

  void logout() {}
}
