import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/app_bar/default_app_bar.dart';
import '../../common_widgets/base/base_page.dart';
import '../../common_widgets/space_box.dart';
import '../../data/repository/profile/profile_repository.dart';
import '../../resource/app_text_styles.dart';
import 'profile_state.dart';
import 'profile_view_model.dart';
import 'widget/profile_view_card.dart';

final _provider =
    StateNotifierProvider.autoDispose<ProfileViewModel, ProfileState>(
  (ref) => ProfileViewModel(
    profileRepository: ProfileRepository(ref),
    reader: ref,
  ),
);

class ProfilePage extends BasePage {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends BasePageState<ProfilePage> {
  @override
  void onInitState() {
    super.onInitState();
    Future.delayed(Duration.zero, () {
      ref.read(_provider.notifier).init();
    });
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => DefaultAppBar(
        onLeftTapped: () {
          Navigator.of(context).pop();
        },
        title: AppLocalizations.of(context)!.profile,
      );

  @override
  Widget body(BuildContext context) {
    final state = ref.watch(_provider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.profile,
            style: AppTextStyles.fontPoppinsBold18.copyWith(
              color: Colors.white,
            ),
          ),
          const SpaceBox.height(10),
          ProfileOverViewCard(
            onTap: () {},
            orderCount: state.orderCount,
            cartCount: state.cartCount,
          ),
        ],
      ),
    );
  }
}
