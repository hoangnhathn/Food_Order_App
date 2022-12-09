import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/app_bar/default_app_bar.dart';
import '../../common_widgets/base/base_page.dart';
import '../../common_widgets/input_part/input_text_area.dart';
import '../../data/model/db/db_food_info.dart';
import '../../data/model/db/db_shop_info.dart';
import '../../data/provider/app_navigator_provider.dart';
import '../../data/repository/search_list/search_list_repository.dart';
import '../../navigation/app_route.dart';
import '../../resource/app_color.dart';
import '../../resource/app_text_styles.dart';
import '../../resource/constants.dart';
import '../food_detail/top/model/food_detail_top_arguments.dart';
import '../food_detail/top/widget/card_large_order.dart';
import '../home/widget/large_card.dart';
import 'model/search_list_arguments.dart';
import 'search_list_state.dart';
import 'search_list_view_model.dart';

final _provider =
    StateNotifierProvider.autoDispose<SearchListViewModel, SearchListState>(
  (ref) => SearchListViewModel(
    searchListRepository: SearchListRepository(ref),
    reader: ref,
  ),
);

class SearchListPage extends BasePage {
  const SearchListPage({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  final SearchListArguments arguments;

  @override
  SearchListPageState createState() => SearchListPageState();
}

class SearchListPageState extends BasePageState<SearchListPage> {
  @override
  Color get backgroundColor => context.colors.baseBackgroundColor;

  @override
  bool get tapOutsideHideKeyboard => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => DefaultAppBar(
        onLeftTapped: () {
          Navigator.of(context).pop();
        },
        title: AppLocalizations.of(context)!.resultTerm,
      );

  @override
  void onInitState() {
    super.onInitState();

    Future.delayed(Duration.zero, () {
      ref.read(_provider.notifier).init(widget.arguments);
    });
  }

  @override
  Widget body(BuildContext context) {
    final foods = ref.watch(_provider).foods;
    final shops = ref.watch(_provider).shops;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          if (ref.read(_provider.notifier).showSearchInput())
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: Constants.spaceWidth,
              ),
              child: InputTextArea(
                onChanged: (value) {
                  ref.read(_provider.notifier).searchInput(value);
                },
                hintText: AppLocalizations.of(context)!.searchDishRestaurant,
                backgroundColor: Colors.white,
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (shops.isNotEmpty && foods.isNotEmpty)
                    _buildTitle(AppLocalizations.of(context)!.shopTerm),
                  if (shops.isNotEmpty) _buildShopList(shops),
                  if (shops.isNotEmpty && foods.isNotEmpty)
                    _buildTitle(AppLocalizations.of(context)!.foodTerm),
                  if (foods.isNotEmpty) _buildFoodList(foods),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Constants.spaceWidth,
      ),
      child: Text(
        title,
        style: AppTextStyles.fontPoppinsRegular15.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildShopList(List<DbShopInfo> shops) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shops.length,
      itemBuilder: (context, index) {
        final shop = shops[index];
        return LargeCard(
          shop: shop,
          onTap: () {
            _navigateToFoodDetailPage(
              shop.id ?? 0,
            );
          },
          isExpanded: true,
        );
      },
    );
  }

  Widget _buildFoodList(List<DbFoodInfo> foods) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final food = foods[index];
        return CardLargeOrder(
          onTap: () {
            _navigateToFoodDetailPage(
              food.shopInfoId,
            );
          },
          isEnableAdd: false,
          food: food,
        );
      },
      itemCount: foods.length,
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.spaceWidth,
          ),
          child: Divider(
            height: 1,
            color: Colors.black38,
          ),
        );
      },
    );
  }

  void _navigateToFoodDetailPage(int shopId) {
    ref.read(appNavigatorProvider).navigateTo(
          AppRoute.foodDetailPage,
          arguments: FoodDetailTopArguments(
            shopId: shopId,
          ),
        );
  }
}
