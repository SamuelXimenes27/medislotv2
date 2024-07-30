import 'package:flutter/material.dart';

PreferredSizeWidget buildDefaultAppBar(
  BuildContext context, {
  required String title,
  required void Function()? onPressed,
  List<Widget>? actions,
}) {
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;
  return AppBar(
    backgroundColor: colorScheme.background,
    centerTitle: true,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(10),
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.chevron_left,
        color: colorScheme.primary,
      ),
      onPressed: onPressed,
    ),
    actions: actions,
    title: Text(
      title,
      style: textTheme.headline6!.copyWith(
        color: colorScheme.primaryContainer,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
