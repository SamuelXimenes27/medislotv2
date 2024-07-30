import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import '../../../ui/mixins/mixins.dart';

class SplashPage extends StatelessWidget with NavigationManager {
  final SplashPresenter presenter;

  const SplashPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleNavigation(presenter.navigatoToStream, clear: true);

          return SizedBox.expand(
            child: Image.asset(
              'lib/ui/assets/imgs/splash_screen.png',
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
