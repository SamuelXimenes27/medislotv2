import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonBackComponent extends StatelessWidget {
  final int idPage;

  const ButtonBackComponent({Key? key, required this.idPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Positioned(
      left: 10,
      top: 60,
      child: GestureDetector(
        onTap: () {
          Get.offNamed('/clinic/$idPage');
          Get.back();
        },
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Icon(
            Icons.chevron_left,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
