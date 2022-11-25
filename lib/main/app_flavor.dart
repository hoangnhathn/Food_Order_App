enum AppFlavorType { development, production }

class AppFlavor {
  AppFlavor({
    required this.appFlavorType,
  });

  AppFlavorType appFlavorType;
}

class AppFlavorValue {
  static final development = AppFlavor(
    appFlavorType: AppFlavorType.development,
  );

  static final production = AppFlavor(
    appFlavorType: AppFlavorType.production,
  );
}
