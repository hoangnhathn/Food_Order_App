import 'package:intl/intl.dart';

import '../../resource/constants.dart';

extension IntExtension on int {
  String get distanceStr {
    return '${this}m';
  }

  String get timeStr {
    return '${this}m';
  }

  String address() {
    return '${this} địa điểm';
  }

  String get priceFormat {
    if (abs() < Constants.minNumberToFormat) {
      return toString();
    }

    final numberFormat = NumberFormat('#,###,000');
    return numberFormat.format(this);
  }

  String get formatQuantity {
    return '$this x';
  }

  String get formatComment {
    return '($this+ Bình luận)';
  }
}
