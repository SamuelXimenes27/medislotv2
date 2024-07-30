import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/pages/pages.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    Key? key,
    required this.isDisable,
    required this.onPressed,
  }) : super(key: key);

  final bool isDisable;
  final void Function()? onPressed;
  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool get _isDisable => widget.isDisable;
  void Function()? get _onPressed => widget.onPressed;

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<MakeAppointmentPresenter>(context);
    return StreamBuilder<bool>(
        stream: _presenter.isLoadingPaymentCheckoutStream,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return const CircularProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: _isDisable
                        ? MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)
                        : MaterialStateProperty.all(Colors.grey),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: _onPressed,
                  child: const Text('Marcar'),
                ),
              ),
            );
          }
        });
  }
}
