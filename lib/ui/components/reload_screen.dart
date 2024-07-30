import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required String error,
  required Future<void> Function() action,
  double height = 335,
  String? title,
}) async {
  await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      content: SizedBox(
        width: 335,
        height: height,
        child: ReloadScreen(
          error: error,
          action: action,
          title: title,
        ),
      ),
    ),
  );
}

class ReloadScreen extends StatelessWidget {
  const ReloadScreen(
      {Key? key, required this.error, required this.action, this.title})
      : super(key: key);
  final String error;
  final Future<void> Function() action;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'lib/ui/assets/imgs/img_sad_cloud.png',
          height: 70,
        ),
        const SizedBox(height: 20),
        Text(
          title ?? 'Ooopsss...',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 5),
        Text(error),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: action,
          child: Text(R.string.reload),
        )
      ],
    );
  }
}
