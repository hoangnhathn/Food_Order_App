import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/profile/profile_repository.dart';
import 'profile_state.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel({
    required this.profileRepository,
    required this.reader,
  }) : super(ProfileState());

  ProfileRepository profileRepository;

  Ref reader;

  Future<void> init() async {
    final cartCount = await profileRepository.getCartCount();
    final orderCount = await profileRepository.getOrderCount();

    state = state.copyWith(
      cartCount: cartCount,
      orderCount: orderCount,
    );
  }

  void logout() {}
}
