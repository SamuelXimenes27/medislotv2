import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError?>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: R.string.password,
            errorText: snapshot.data?.description,
            suffixIcon: GestureDetector(
              onTap: () {
                isShowPassword = !isShowPassword;
                setState(() {});
              },
              child: isShowPassword
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
            ),
          ),
          cursorColor: Theme.of(context).colorScheme.secondary,
          obscureText: isShowPassword,
          onChanged: presenter.validatePassword,
        );
      },
    );
  }
}
