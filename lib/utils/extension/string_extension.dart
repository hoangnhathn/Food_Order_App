extension StringExtension on String {
  int toInt() {
    return int.parse(this);
  }

  String get formatCurrency {
    return '$this VND';
  }

  /// Format URL Image By Size
  /// Eg: https://images.foody.vn/res/g115/1148609/prof/s640x400/foody-upload-api-foody-mobile-av-08b82729-220822131550.jpeg
  /// => https://images.foody.vn/res/g115/1148609/prof/s100x100/foody-upload-api-foody-mobile-av-08b82729-220822131550.jpeg
  /// Replace by fit size [640, 400] => [100, 100]
  String urlImageBySize() {
    return '';
  }
}
