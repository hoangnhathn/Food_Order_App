import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/sq_lite_client.dart';

final sqLiteClientProvider = FutureProvider((ref) async {
  return Future.value(SQFLiteClient(ref));
});
