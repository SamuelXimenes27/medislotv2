import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../ui/mixins/mixins.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with KeyboardManager, LoadingManager, UIErrorManager, NavigationManager {
  @override
  void initState() {
    handleMainError(context, widget.presenter.mainErrorStream, () {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      return Future.value(null);
    });
    handleNavigation(widget.presenter.navigateToStream, clear: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => hideKeyboard(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 40, bottom: 15),
                    child: Image.asset(
                      'lib/ui/assets/imgs/header_login.png',
                      fit: BoxFit.cover,
                      height: 280,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          R.string.signIn,
                          style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListenableProvider(
                          create: (_) => widget.presenter,
                          child: Form(
                            child: Column(
                              children: const [
                                EmailInput(),
                                SizedBox(
                                  height: 15,
                                ),
                                PasswordInput(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: widget.presenter.goToForgotPassword,
                              child: Text(
                                R.string.forgotPassword,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListenableProvider(
                          create: (_) => widget.presenter,
                          child: const LoginButton(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                          height: 2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            R.string.dontHaveAnAccount,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: widget.presenter.goToSignUp,
                            child: Text(
                              R.string.signUp,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
