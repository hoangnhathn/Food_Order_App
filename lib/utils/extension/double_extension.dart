extension DoubleExtension on double{
  String get percentString => '$this%';

  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}