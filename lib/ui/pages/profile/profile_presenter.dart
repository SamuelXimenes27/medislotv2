import 'package:flutter/material.dart';

import '../../../ui/ui.dart';

abstract class ProfilePresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSessionExpiredStream;
  Stream<String?> get navigateToStream;

  Stream<ProfileViewModel?> get profileStream;
  Stream<LanguageOption?> get currentLanguage;

  Future<void> loadPage();

  Future<void> goToChangePassword();
  Future<void> changeLanguage(LanguageOption locale);
}
