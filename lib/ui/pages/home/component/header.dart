import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class Header extends StatelessWidget {
  final Function openDrawer;
  final Function(String) nameForDrawer;
  const Header({
    Key? key,
    required this.openDrawer,
    required this.nameForDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<HomePresenter>(context);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              GestureDetector(
                onTap: Scaffold.of(context).openDrawer,
                child: Image.asset(
                  'lib/ui/assets/imgs/icon_profile.png',
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              builderName(_presenter),
            ],
          ),
        ),
        Image.asset(
          'lib/ui/assets/imgs/icon_notification.png',
          height: 24,
        )
      ],
    );
  }

  Widget builderName(HomePresenter presenter) {
    return StreamBuilder<HomeProfileViewmodel?>(
      stream: presenter.profileStream,
      builder: (context, snapshot) {
        // if (snapshot.hasError) {
        //   showErrorDialog(context, error: '${snapshot.error}', action: presenter.loadHomePage);
        // }

        if (snapshot.hasData) {
          final _fullName = snapshot.data!.name;
          final _firstName = _fullName.split(' ').first;
          final _lastName = _fullName.split(' ').last;

          nameForDrawer('$_firstName $_lastName');
          return Text(
            '${R.string.hello} $_firstName',
            style: Theme.of(context).textTheme.headline6,
          );
        }

        return Container();
      },
    );
  }
}
