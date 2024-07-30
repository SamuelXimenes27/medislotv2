import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';

class PriceTile extends StatelessWidget {
  final SpecialityEntity? specialtySelected;
  const PriceTile({
    Key? key,
    required this.specialtySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        isThreeLine: true,
        title: Text(R.string.price),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              specialtySelected == null ? '--' : specialtySelected!.price.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
