import 'search_condition_type.dart';

class SearchListArguments {
  SearchListArguments({
    required this.searchConditionType,
    this.categoryId,
  });

  final SearchConditionType searchConditionType;

  final int? categoryId;
}
