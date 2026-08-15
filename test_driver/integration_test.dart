import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (
      String name,
      List<int> bytes, [
      Map<String, Object?>? args,
    ]) async {
      final dir = Directory('docs/prints');
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      File('docs/prints/$name.png').writeAsBytesSync(bytes);
      return true;
    },
  );
}
