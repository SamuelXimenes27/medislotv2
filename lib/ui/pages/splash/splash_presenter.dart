import 'package:flutter/material.dart';

abstract class SplashPresenter implements Listenable {
  Stream<String?> get navigatoToStream;

  Future<void> checkAccount({int durationInSeconds});
}
