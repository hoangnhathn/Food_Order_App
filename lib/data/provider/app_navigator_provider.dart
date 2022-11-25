import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigation/app_navigator.dart';

final appNavigatorProvider = Provider<AppNavigator>(
  (ref) => AppNavigator(read: ref),
);
