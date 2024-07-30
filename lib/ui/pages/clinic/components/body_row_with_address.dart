import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/pages/pages.dart';

class BodyRowWithAddress extends StatelessWidget {
  final ClinicEntity clinic;
  const BodyRowWithAddress({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<ClinicPresenter>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _presenter.goToGoogleMaps,
      child: Row(
        children: [
          Image.asset('lib/ui/assets/imgs/icon_find_clinic.png', height: 25),
          Expanded(
            child: ListTile(
              title: Text(
                clinic.address!,
                style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text('${clinic.city!.first.name}, ${clinic.district!.first.name}'),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
