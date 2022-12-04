import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../resource/app_color.dart';
import 'app_navigator_provider.dart';

final modalBottomSheetProvider = Provider<ModalBottomSheet>(
  (ref) => ModalBottomSheet(ref),
);

class ModalBottomSheet {
  ModalBottomSheet(this.reader);

  final Ref reader;

  Future<T?> showModal<T>({
    required WidgetBuilder builder,
    String? routeName,
  }) {
    final currentContext =
        reader.read(appNavigatorProvider).navigatorKey.currentContext;
    if (currentContext == null) {
      return Future.value();
    }

    return showModalBottomSheet<T>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      context: currentContext,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      barrierColor: currentContext.colors.black.withOpacity(0.5),
      builder: builder,
      routeSettings: RouteSettings(name: routeName),
    );
  }
}
