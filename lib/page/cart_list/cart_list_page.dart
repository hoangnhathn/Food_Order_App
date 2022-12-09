import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/base/base_page.dart';
import '../../data/model/db/db_order_item_info.dart';
import '../../data/provider/app_navigator_provider.dart';
import '../../data/repository/cart_list/cart_list_respository.dart';
import '../../gen/assets.gen.dart';
import '../../navigation/app_route.dart';
import '../../resource/app_color.dart';
import '../../resource/app_text_styles.dart';
import '../food_detail/final_confirm_order/model/cart_food.dart';
import '../food_detail/final_confirm_order/widget/card_order_expand.dart';
import '../food_detail/top/model/food_detail_top_arguments.dart';
import 'cart_list_state.dart';
import 'cart_list_view_model.dart';
import 'widget/card_order_item.dart';

final _provider =
    StateNotifierProvider.autoDispose<CartListViewModel, CartListState>(
  (ref) => CartListViewModel(
    cartListRepository: CartListRepository(ref),
    reader: ref,
  ),
);

class CartListPage extends BasePage {
  const CartListPage({Key? key}) : super(key: key);

  @override
  CartListPageState createState() => CartListPageState();
}

class CartListPageState extends BasePageState<CartListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void onInitState() {
    super.onInitState();

    Future.delayed(Duration.zero, () {
      ref.read(_provider.notifier).init();
    });

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(_provider.notifier).changeIndex(_tabController.index);
      }
    });
  }

  @override
  Color get backgroundColor => context.colors.baseBackgroundColor;

  @override
  Widget body(BuildContext context) {
    final indexSelected = ref.watch(_provider).indexSelected;
    final carts = ref.watch(_provider).cartFoods;
    final orderItems = ref.watch(_provider).orderItems;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Image.asset(
              Assets.images.icBackBlack.path,
              height: 18,
              width: 18,
            ),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myOrder,
          style: AppTextStyles.fontPoppinsRegular18.copyWith(
            color: Colors.black,
          ),
        ),
        bottom: TabBar(
          tabs: [
            tabNavigator(
              AppLocalizations.of(context)!.cartTerm,
              indexSelected == 0,
            ),
            tabNavigator(
              AppLocalizations.of(context)!.orderTerm,
              indexSelected == 1,
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          _buildCartList(carts),
          _buildOrderList(orderItems),
        ],
      ),
    );
  }

  Tab tabNavigator(
    String title,
    bool isSelected,
  ) {
    return Tab(
      child: Text(
        title,
        style: AppTextStyles.fontPoppinsRegular15.copyWith(
          color: isSelected ? Colors.orangeAccent : Colors.black,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCartList(List<CartFood> cartFoods) {
    return ListView.builder(
      itemCount: cartFoods.length,
      itemBuilder: (context, index) {
        final cartFood = cartFoods[index];
        return CardOrderExpand(
          cartFood: cartFood,
          onTap: () {
            _navigateToFoodDetailPage(cartFood.food.id ?? 1);
          },
        );
      },
    );
  }

  Widget _buildOrderList(List<DbOrderItemInfo> orderItems) {
    return ListView.builder(
      itemCount: orderItems.length,
      itemBuilder: (context, index) {
        final orderItem = orderItems[index];
        return CardOrderItem(
          orderItem: orderItem,
        );
      },
    );
  }

  void _navigateToFoodDetailPage(int foodInfoId) {
    ref.read(appNavigatorProvider).navigateTo(
          AppRoute.foodDetailPage,
          arguments: FoodDetailTopArguments(
            foodId: foodInfoId,
          ),
        );
  }
}
