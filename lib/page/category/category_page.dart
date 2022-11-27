import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../../common_widgets/base/base_page.dart';

class CategoryPage extends BasePage {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends BasePageState<CategoryPage> {
  @override
  Widget body(BuildContext context) {
    throw UnimplementedError();
  }
}
