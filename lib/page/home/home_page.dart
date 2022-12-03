import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/app_bar/icon_transition_app_bar.dart';
import '../../common_widgets/base/base_page.dart';
import '../../common_widgets/control/line_title_transition.dart';
import '../../common_widgets/space_box.dart';
import '../../data/model/category/category_food.dart';
import '../../data/model/db/db_food_info.dart';
import '../../data/provider/app_navigator_provider.dart';
import '../../data/repository/user_repository/user_repository.dart';
import '../../gen/assets.gen.dart';
import '../../navigation/app_route.dart';
import '../../resource/app_text_styles.dart';
import '../../resource/constants.dart';
import '../food_detail/top/model/food_detail_top_arguments.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widget/banner_card.dart';
import 'widget/item_category.dart';
import 'widget/large_card.dart';
import 'widget/medium_card.dart';

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
    final categories = ref.watch(homeViewModel).categories;
    final banners = ref.watch(homeViewModel).banners;
    final recommends = ref.watch(homeViewModel).recommends;
    final populars = ref.watch(homeViewModel).populars;
    return Column(
      children: [
        const IconTransitionAppBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GestureDetector(
            onTap: () {},
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
                    AppLocalizations.of(context)!.searchDishRestaurant,
                    style: AppTextStyles.fontPoppinsRegular14.copyWith(
                      color: Colors.black26,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LineTitleTransition(
                  onTap: () {},
                  title: AppLocalizations.of(context)!.popularNear,
                  titleTransition: AppLocalizations.of(context)!.viewMore,
                ),
                buildPopularItem(populars),
                const SpaceBox.height(),
                LineTitleTransition(
                  onTap: () {
                    ref
                        .read(appNavigatorProvider)
                        .navigateTo(AppRoute.categoryPage);
                  },
                  title: AppLocalizations.of(context)!.exploreCategory,
                  titleTransition: AppLocalizations.of(context)!.showAll,
                ),
                buildItemCategory(categories),
                LineTitleTransition(
                  onTap: () {},
                  title: AppLocalizations.of(context)!.recommended,
                  titleTransition: AppLocalizations.of(context)!.showAll,
                ),
                buildRecommended(recommends),
                const SpaceBox.height(),
                buildBanner(banners),
                const SpaceBox.height(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPopularItem(List<DbFoodInfo> populars) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SpaceBox.width(
            Constants.spaceWidth,
          ),
          ...populars.map((food) {
            return LargeCard(
              food: food,
              onTap: () {
                _navigateToFoodDetailPage(food.id ?? 0);
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildItemCategory(List<CategoryFood> categories) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SpaceBox.width(
            Constants.spaceWidth,
          ),
          ...categories.map((category) {
            return ItemCategory(
              category: category,
              onTap: () {},
              isLastItem: categories.last == category,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildRecommended(List<DbFoodInfo> recommends) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SpaceBox.width(
            Constants.spaceWidth,
          ),
          ...recommends.map((food) {
            return MediumCard(
              food: food,
              onTap: () {
                _navigateToFoodDetailPage(food.id ?? 0);
              },
              isLastItem: recommends.last == food,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildBanner(List<String> banners) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SpaceBox.width(
            Constants.spaceWidth,
          ),
          ...banners.map((banner) {
            return CardBanner(
              onTap: () {},
              image: banner,
              isLastItem: banners.last == banner,
            );
          }).toList()
        ],
      ),
    );
  }

  void _navigateToFoodDetailPage(int id) {
    ref.read(appNavigatorProvider).navigateTo(
          AppRoute.foodDetailPage,
          arguments: FoodDetailTopArguments(id: id),
        );
  }
}
