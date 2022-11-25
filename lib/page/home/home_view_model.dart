import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/db/db_user_info.dart';
import '../../data/repository/user_repository/user_repository.dart';
import 'home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required this.userRepository,
    required this.reader,
  }) : super(HomeState.initial());

  Ref reader;
  UserRepository userRepository;

  Future<void> init() async {
    final userInfo = await userRepository.getCurrentUser();
    state = state.copyWith(
      userInfo: userInfo!,
    );
  }
}