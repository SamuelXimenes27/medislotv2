import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class ProfileBody extends StatefulWidget {
  final ProfileViewModel profile;
  final LanguageOption currentLanguage;
  const ProfileBody({Key? key, required this.profile, required this.currentLanguage}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late TextTheme textTheme;
  late ProfilePresenter _presenter;

  LanguageOption get _languageOption => widget.currentLanguage;

  late String? languageSelected;

  List<String> languages = ['EN', 'PT', 'FR'];

  Future<void> showConfirmChangeLanguageDialog(String option) async {
    await Future.delayed(Duration.zero);
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: SizedBox(
            height: 180,
            width: 335,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  R.string.doYouSureSwitchLanguage,
                  style: textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  R.string.theApplicationWillRestart,
                  style: textTheme.headline6,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            R.string.cancel,
                            style: textTheme.bodyText1!.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          switch (option) {
                            case 'EN':
                              _presenter.changeLanguage(LanguageOption.enUs);
                              break;
                            case 'PT':
                              _presenter.changeLanguage(LanguageOption.ptBr);
                              break;
                            default:
                              _presenter.changeLanguage(LanguageOption.fr);
                              break;
                          }
                        },
                        child: Text(R.string.yesIdo),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  _setUpCurrentLanguage() {
    switch (_languageOption) {
      case LanguageOption.enUs:
        languageSelected = 'EN';
        break;
      case LanguageOption.ptBr:
        languageSelected = 'PT';
        break;
      default:
        languageSelected = 'FR';
    }
  }

  @override
  void initState() {
    _setUpCurrentLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _presenter = Provider.of<ProfilePresenter>(context);
    final firstName = widget.profile.name.split(' ').first;
    final lastName = widget.profile.name.split(' ').last;

    final firstLetter = firstName.substring(0, 1).toUpperCase();
    final fristLetterLastName = lastName.substring(0, 1).toUpperCase();

    textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 48),
        CircleWithInitialLetters(
          size: 95,
          initialLetters: '$firstLetter$fristLetterLastName',
        ),
        const SizedBox(height: 13),
        Text('$firstName $lastName', style: textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 22),
        const Divider(),
        const SizedBox(height: 10),
        buildItem('Name', widget.profile.name),
        const SizedBox(height: 10),
        buildItem('E-mail', widget.profile.email ?? ''),
        const SizedBox(height: 10),
        buildItem('Phone', widget.profile.phone ?? ''),
        const SizedBox(height: 10),
        buildLanguagePreference(),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerRight,
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: _presenter.goToChangePassword,
              child: Text(
                R.string.changePasswordOnWebsite,
                style: textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  color: colorScheme.primaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLanguagePreference() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              R.string.languagePreference,
              style: textTheme.bodyText1!.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          DropdownButton<String>(
            underline: const SizedBox(),
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.black,
            ),
            value: languageSelected,
            borderRadius: BorderRadius.circular(10),
            isDense: true,
            hint: Text(languageSelected ?? "", style: const TextStyle(color: Colors.black45, fontSize: 14)),
            items: languages.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              showConfirmChangeLanguageDialog(value!);
            },
          ),
        ],
      ),
    );
  }

  Widget buildItem(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            height: 35,
            child: Column(
              children: [
                Text(
                  key,
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
