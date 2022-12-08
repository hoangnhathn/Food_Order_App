import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/base/base_page.dart';
import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../data/model/db/db_shop_info.dart';
import '../../../data/provider/app_navigator_provider.dart';
import '../../../data/provider/modal_bottom_sheet_provider.dart';
import '../../../data/repository/food_detail_top/food_detail_top_repository.dart';
import '../../../gen/assets.gen.dart';
import '../../../navigation/app_route.dart';
import '../../../resource/app_color.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';
import '../final_confirm_order/model/final_confirm_order_arguments.dart';
import '../order/food_detail_order_page.dart';
import '../order/model/food_detail_order_arguments.dart';
import '../widget/card_popular_order.dart';
import 'food_detail_top_state.dart';
import 'food_detail_top_view_model.dart';
import 'model/food_detail_top_arguments.dart';
import 'widget/card_large_order.dart';
import 'widget/custom_sliver_app_bar.dart';

const double heightBottomOrder = 60;

final _provider = StateNotifierProvider.autoDispose<FoodDetailTopViewModel,
    FoodDetailTopState>(
  (ref) => FoodDetailTopViewModel(
    foodDetailTopRepository: FoodDetailTopRepository(ref),
    reader: ref,
  ),
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
    final shop = ref.watch(_provider).shopInfo;
    final popularFoods = ref.watch(_provider).popularFoods;
    final filterCategoryFoods = ref.watch(_provider).filterCategoryFoods;
    final carts = ref.watch(_provider).carts;
    return Stack(
      children: [
        CustomSliverAppBar(
          title: shop?.name ?? '',
          onLeftTap: () {
            Navigator.of(context).pop();
          },
          urlBackground: shop?.banner ?? Constants.dummyImage,
          buildBody: SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShopInfoContainer(shop),
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
                                  if (popularFoods != null)
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
                      if (filterCategoryFoods != null)
                        _buildListLargeOrder(filterCategoryFoods),
                      if (carts?.isNotEmpty ?? false)
                        const SpaceBox.height(heightBottomOrder),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (carts?.isNotEmpty ?? false)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: bottomOrderCart(),
          )
      ],
    );
  }

  Widget _buildShopInfoContainer(DbShopInfo? shopInfo) {
    if (shopInfo != null) {
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
                    shopInfo.name,
                    style: AppTextStyles.fontPoppinsBold20.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceBox.height(5),
            Text(
              shopInfo.title,
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
                  '${shopInfo.rating.toString()} (${shopInfo.comment}+ Bình luận)',
                  style: AppTextStyles.fontPoppinsRegular15.copyWith(
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                itemChip(
                  Assets.images.icLocationRed.path,
                  shopInfo.distance.distanceStr,
                ),
                const SpaceBox.width(),
                itemChip(
                  Assets.images.icTimeRed.path,
                  shopInfo.time.timeStr,
                ),
                const SpaceBox.width(5),
              ],
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> _navigateToFinalConfirmOrder() async {
    await ref.read(appNavigatorProvider).navigateTo(
          AppRoute.finalConfirmationOrderPage,
          arguments: FinalConfirmOrderArguments(
            shopId: widget.arguments.shopId ?? 0,
          ),
        );
    await ref.read(_provider.notifier).refreshCart();
  }

  Widget bottomOrderCart() {
    return Container(
      height: heightBottomOrder,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: Constants.spaceWidth,
            ),
            child: Image.asset(
              Assets.images.icShoppingCart.path,
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Spacer(),
          Text(
            ref.watch(_provider).totalPrice.toString(),
            style: AppTextStyles.fontPoppinsBold15.copyWith(
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              _navigateToFinalConfirmOrder();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.teal,
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.shipOrder,
                  style: AppTextStyles.fontPoppinsRegular15.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
              onOrderTap: () {
                _navigateToFoodOrderPage(food);
              },
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
        final food = filterCategoryFoods[index];
        return CardLargeOrder(
          onTap: () {},
          onOrderTap: () {
            _navigateToFoodOrderPage(food);
          },
          food: food,
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

  Future<void> _navigateToFoodOrderPage(DbFoodInfo food) async {
    await ref.read(modalBottomSheetProvider).showModal(
      builder: (context) {
        return FoodDetailOrderPage(
          arguments: FoodDetailOrderArguments(
            dbFoodInfo: food,
          ),
        );
      },
    );
    await ref.read(_provider.notifier).refreshCart();
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
