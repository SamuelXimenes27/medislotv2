import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medislot/ui/pages/home/home_presenter.dart';
import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../helpers/i18n/resources.dart';

class DrawerComponent extends StatelessWidget {
  final String name;
  const DrawerComponent({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final firstLetter = name.split(' ').first.substring(0, 1).toUpperCase();
    final fristLetterLastName = name.split(' ').last.substring(0, 1).toUpperCase();

    final _presenter = Provider.of<HomePresenter>(context);

    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 65),
          CircleWithInitialLetters(initialLetters: '$firstLetter$fristLetterLastName'),
          const SizedBox(height: 13),
          Text(
            name,
            style: textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xff1C1C1C),
            ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 21),
          buildListTile(context, 'lib/ui/assets/imgs/icon_user.png', R.string.profile, () => _goTo(0)),
          buildListTile(context, 'lib/ui/assets/imgs/icon_calendar.png', R.string.upcoming, () => _goTo(1)),
          buildListTile(context, 'lib/ui/assets/imgs/icon_clock.png', R.string.history, () => _goTo(2)),
          buildListTile(context, 'lib/ui/assets/imgs/icon_info.png', R.string.privacyPolicies, () {
            _presenter.goToPrivacyPolicyPage();
          }),
          buildListTile(context, 'lib/ui/assets/imgs/icon_log_out_red.png', R.string.logout, () {
            _presenter.logout();
            _goTo(4);
          }),
        ],
      ),
    );
  }

  void _goTo(int id) {
    switch (id) {
      case 0:
        Get.toNamed('/profile');
        break;
      case 1:
        Get.toNamed('/upcoming');
        break;
      case 2:
        Get.toNamed('/history');
        break;
      default:
        Get.offAllNamed('/login');
        break;
    }
  }

  Widget buildListTile(BuildContext context, String pathIcon, String title, Function() onTap) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        minLeadingWidth: 10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Image.asset(pathIcon, height: 24),
        title: Text(
          title,
          style: textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
            color: title == R.string.logout ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }
}
