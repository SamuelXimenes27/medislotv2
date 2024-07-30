import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return StreamBuilder<bool>(
          stream: presenter.isLoadingStream,
          builder: (context, snapshotLoading) {
            bool isLoading = snapshotLoading.hasData && snapshotLoading.data == true;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: snapshot.data == true ? presenter.auth : null,
                  child: Text(
                    R.string.signIn,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
