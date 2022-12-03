extension StringExtension on String {
  int toInt() {
    return int.parse(this);
  }

  String get formatCurrency {
    return '$this VND';
  }
}
