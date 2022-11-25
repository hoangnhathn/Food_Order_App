import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/sq_lite_client.dart';
import '../provider/secure_storage_provider.dart';
import '../provider/sq_lite_client_provider.dart';
import '../secure_storage/secure_storage.dart';

abstract class Repository {
  Repository(this.reader) : super();

  Ref reader;

  /// [SQFLiteClient]
  Future<SQFLiteClient> sqfLiteClient() async =>
      await reader.read(sqLiteClientProvider.future);

  SecureStorage get secureStorage => reader.read(secureStorageProvider);
}
