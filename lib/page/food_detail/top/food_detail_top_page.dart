import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/base/base_page.dart';
import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../gen/assets.gen.dart';
import '../../../resource/app_color.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';
import 'food_detail_top_state.dart';
import 'food_detail_top_view_model.dart';
import 'model/food_detail_top_arguments.dart';
import 'widget/card_large_order.dart';
import 'widget/card_popular_order.dart';
import 'widget/custom_sliver_app_bar.dart';

final _provider = StateNotifierProvider.autoDispose<FoodDetailTopViewModel,
    FoodDetailTopState>(
  (ref) => FoodDetailTopViewModel(),
);

class FoodDetailPage extends BasePage {
  const FoodDetailPage({required this.arguments, Key? key}) : super(key: key);

  final FoodDetailTopArguments arguments;

  @override
  FoodDetailPageState createState() => FoodDetailPageState();
}

class FoodDetailPageState extends BasePageState<FoodDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Color get backgroundColor => context.colors.baseBackgroundColor;

  @override
  void onInitState() {
    super.onInitState();
    Future.delayed(const Duration(seconds: 0), () {
      ref.read(_provider.notifier).init(
            widget.arguments,
          );
    });

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {}
    });
  }

  @override
  Widget body(BuildContext context) {
    final food = ref.watch(_provider).food;
    final popularFoods = ref.watch(_provider).popularFoods;
    final filterCategoryFoods = ref.watch(_provider).filterCategoryFoods;
    return CustomSliverAppBar(
      title: food.title,
      onLeftTap: () {
        Navigator.of(context).pop();
      },
      urlBackground:
          'https://images.foody.vn/res/g115/1148609/prof/s640x400/foody-upload-api-foody-mobile-av-08b82729-220822131550.jpeg',
      buildBody: SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShopInfoContainer(food),
                  const SpaceBox.height(),
                  _buildDeliveryContainer(),
                  const SpaceBox.height(),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: Constants.spaceWidth,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.popularFood,
                                  style: AppTextStyles.fontOpenSansRegular15
                                      .copyWith(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                              listPopularFood(popularFoods),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  DefaultTabController(
                    length: 3,
                    child: TabBar(
                      indicatorColor: Colors.deepOrange,
                      tabs: [
                        tabFilter(AppLocalizations.of(context)!.newFood),
                        tabFilter(AppLocalizations.of(context)!.waterDish),
                        tabFilter(AppLocalizations.of(context)!.fryFood),
                      ],
                      onTap: (index) {},
                    ),
                  ),
                  _buildListLargeOrder(filterCategoryFoods),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopInfoContainer(DbFoodInfo food) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: Constants.spaceWidth,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.icProtected.path,
                width: 20,
                height: 20,
              ),
              const SpaceBox.width(),
              Expanded(
                child: Text(
                  food.title,
                  style: AppTextStyles.fontPoppinsBold20.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SpaceBox.height(5),
          Text(
            food.subTitle,
            style: AppTextStyles.fontPoppinsRegular15.copyWith(
              color: Colors.black38,
            ),
          ),
          const SpaceBox.height(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.icStar.path,
                height: 15,
                width: 15,
              ),
              const SpaceBox.width(3),
              Text(
                '${food.rating.toString()} (999+ Bình luận)',
                style: AppTextStyles.fontPoppinsRegular15.copyWith(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              itemChip(
                Assets.images.icLocationRed.path,
                food.distance.distanceStr,
              ),
              const SpaceBox.width(),
              itemChip(
                Assets.images.icTimeRed.path,
                food.time.timeStr,
              ),
              const SpaceBox.width(5),
            ],
          )
        ],
      ),
    );
  }

  Widget listPopularFood(List<DbFoodInfo> popularFoods) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SpaceBox.width(
            Constants.spaceWidth,
          ),
          ...popularFoods.map((food) {
            return CardPopularOrder(
              onTap: () {},
              food: food,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildListLargeOrder(List<DbFoodInfo> filterCategoryFoods) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CardLargeOrder(
          onTap: () {},
          onOrderTap: () {},
          food: filterCategoryFoods[index],
        );
      },
      itemCount: filterCategoryFoods.length,
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.spaceWidth),
          child: Divider(
            height: 1,
            color: Colors.black38,
          ),
        );
      },
    );
  }

  Widget _buildDeliveryContainer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: Constants.spaceWidth,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepOrangeAccent,
            ),
            child: Image.asset(
              Assets.images.icFoodDeliveryMan.path,
              height: 30,
              width: 30,
            ),
          ),
          const SpaceBox.width(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.standardDelivery,
                style: AppTextStyles.fontOverpassBold15.copyWith(
                  color: Colors.black,
                ),
              ),
              const SpaceBox.height(3),
              const SpaceBox.height(3),
              Text(
                '${AppLocalizations.of(context)!.estimatedDelivery} ${ref.watch(_provider).estimateDelivery}',
                style: AppTextStyles.fontOverpassRegular15.copyWith(
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Tab tabFilter(String title) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.fontPoppinsRegular15.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemChip(String icon, String content) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 15,
            width: 15,
          ),
          const SpaceBox.width(5),
          Text(
            content,
            style: AppTextStyles.fontPoppinsRegular14.copyWith(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}