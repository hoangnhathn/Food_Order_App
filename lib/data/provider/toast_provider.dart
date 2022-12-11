import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/message/toast.dart';

final toastProvider = Provider<AppToast>((ref) => AppToast(ref));

/// Declares this app [Toast]
///
class AppToast {
  AppToast(this.read);

  final Ref read;

  void showToast({
    required BuildContext context,
    required String message,
    Color? color,
    Color? backgroundColor,
  }) {
    BotToast.showCustomNotification(
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      align: Alignment(0, 40 / MediaQuery.of(context).size.height - 1),
      duration: const Duration(seconds: 3),
      backButtonBehavior: BackButtonBehavior.none,
      toastBuilder: (cancel) {
        return Toast(
          message: message,
          backgroundColor: backgroundColor,
          color: color,
        );
      },
      enableSlideOff: true,
      onlyOne: true,
      crossPage: true,
    );
  }
}
