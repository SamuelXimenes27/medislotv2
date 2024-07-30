import 'package:flutter/material.dart';

class BadgeDate extends StatefulWidget {
  const BadgeDate({
    required this.pathIcon,
    required this.text,
    Key? key,
  }) : super(key: key);

  final String pathIcon;
  final String text;

  @override
  State<BadgeDate> createState() => _BadgeDateState();
}

class _BadgeDateState extends State<BadgeDate> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FittedBox(
      child: Container(
        height: 22,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(2, 2),
              color: Colors.black.withOpacity(0.1),
            ),
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(-2, -2),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 6),
            Image.asset(
              widget.pathIcon,
              color: Colors.yellow,
              height: 15,
            ),
            const SizedBox(width: 6),
            Text(
              widget.text,
              style: textTheme.bodyText1!.copyWith(fontSize: 12, color: const Color(0xffB1b1b1)),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
