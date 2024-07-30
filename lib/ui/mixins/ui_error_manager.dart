import '../components/reload_screen.dart';
import '../helpers/errors/errors.dart';

import 'package:flutter/material.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UIError?> stream,
      Future<void> Function() action) {
    // stream.listen((error) {
    //   if (error != null) {
    //     showErrorDialog(context, error: error.description, action: action);
    //   }
    // });
  }
}
