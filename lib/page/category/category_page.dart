import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/app_bar/default_app_bar.dart';
import '../../common_widgets/base/base_page.dart';
import '../../common_widgets/space_box.dart';
import '../../data/provider/app_navigator_provider.dart';
import '../../navigation/app_route.dart';
import '../../resource/constants.dart';
import '../home/widget/item_category.dart';
import '../search_list/model/search_condition_type.dart';
import '../search_list/model/search_list_arguments.dart';
import 'category_state.dart';
import 'category_view_model.dart';

final _provider = StateNotifierProvider<CategoryViewModel, CategoryState>(
  (ref) => CategoryViewModel(),
);

class CategoryPage extends BasePage {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends BasePageState<CategoryPage> {

  @override


  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => DefaultAppBar(
        onLeftTapped: () {
          Navigator.of(context).pop();
        },
        title: AppLocalizations.of(context)!.category,
      );

  @override
  void onInitState() {
    super.onInitState();
    Future.delayed(
      const Duration(seconds: 0),
      () {
        ref.read(_provider.notifier).init();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    final categories = ref.watch(_provider).categories;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.spaceWidth,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Constants.spaceWidth / 2,
                      mainAxisSpacing: Constants.spaceWidth / 2,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ItemCategory(
                        category: category,
                        onTap: () {
                          _navigateToSearchListPage(category.id);
                        },
                        isPaddingRight: false,
                      );
                    },
                  ),
                  const SpaceBox.height(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSearchListPage(int categoryId) {
    ref.read(appNavigatorProvider).navigateTo(
          AppRoute.searchListPage,
          arguments: SearchListArguments(
            searchConditionType: SearchConditionType.viewByCategory,
            categoryId: categoryId,
          ),
        );
  }
}
