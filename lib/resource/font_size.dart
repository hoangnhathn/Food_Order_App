enum FontSize {
  font12,
  font13,
  font14,
  font15,
  font16,
  font17,
  font18,
  font22,
  font23,
  font24,
}

extension FontSizeExtension on FontSize {
  double get fontSize {
    switch (this) {
      case FontSize.font12:
        return 12;
      case FontSize.font13:
        return 13;
      case FontSize.font14:
        return 14;
      case FontSize.font15:
        return 15;
      case FontSize.font16:
        return 16;
      case FontSize.font17:
        return 17;
      case FontSize.font18:
        return 18;
      case FontSize.font22:
        return 22;
      case FontSize.font23:
        return 23;
      case FontSize.font24:
        return 24;
    }
  }
}
