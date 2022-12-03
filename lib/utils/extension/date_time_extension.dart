import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dateString(String format) {
    final engFormat = DateFormat(format);
    return engFormat.format(this);
  }
}
