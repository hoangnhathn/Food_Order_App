import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/base/base_page.dart';
import '../../common_widgets/space_box.dart';
import '../../data/repository/user_repository/user_repository.dart';
import '../../gen/assets.gen.dart';
import '../../resource/app_text_styles.dart';
import 'home_state.dart';
import 'home_view_model.dart';

final homeViewModel = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    userRepository: UserRepository(ref),
    reader: ref,
  ),
);

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  @override
  Color get backgroundColor => const Color(0xffeaeaee);

  @override
  void onInitState() {
    super.onInitState();
    Future.delayed(
      const Duration(seconds: 0),
      () {
        ref.read(homeViewModel.notifier).init();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deliveryTo,
                      style: AppTextStyles.fontOpenSansBold15.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.deliveryTo,
                      style: AppTextStyles.fontOpenSansRegular15.copyWith(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    'https://scontent.fhan14-2.fna.fbcdn.net/v/t1.6435-9/142915405_106600208107240_8287176908190349092_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=aDGoq4IonMwAX9bSeKE&tn=y9erCs1Wd2HJw9GZ&_nc_ht=scontent.fhan14-2.fna&oh=00_AfBGGEUWjM4lDDQUcY64V1EuhGelAQXQzdufNzVvyQT5Wg&oe=63A86D46',
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.icSearch.path,
                    width: 15,
                    height: 15,
                  ),
                  const SpaceBox.width(15),
                  Text(
                    'Search for dish or restaurant',
                    style: AppTextStyles.fontPoppinsRegular14.copyWith(
                      color: Colors.black26,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }
}
