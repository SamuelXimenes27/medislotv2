import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/pages/pages.dart';

class BodyRowWithPhone extends StatelessWidget {
  final ClinicEntity clinic;
  const BodyRowWithPhone({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<ClinicPresenter>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _presenter.goToPhone,
      child: Row(
        children: [
          Image.asset(
            'lib/ui/assets/imgs/icon_phone.png',
            height: 25,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              clinic.phone!,
              style: textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
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
