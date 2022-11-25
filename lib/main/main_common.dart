import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import 'app_flavor.dart';

Future<void> mainCommon(AppFlavor appFlavor) async {
  runApp(
    ProviderScope(
      child: App(
        appFlavor: appFlavor,
      ),
    ),
  );
}
