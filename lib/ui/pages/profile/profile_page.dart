import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../ui/mixins/mixins.dart';

class ProfilePage extends StatefulWidget {
  final ProfilePresenter presenter;
  const ProfilePage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with LoadingManager, NavigationManager, SessionManager, RouteAware {
  ProfilePresenter get _presenter => widget.presenter;

  @override
  void initState() {
    handleLoading(context, _presenter.isLoadingStream);
    handleSessionExpired(_presenter.isSessionExpiredStream);
    handleNavigation(_presenter.navigateToStream, clear: true);
    _presenter.loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar:
          buildDefaultAppBar(context, title: R.string.profile, onPressed: () {
        Get.offNamed('/profile');
        Get.back();
        Get.back();
      }),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: bodyProfileInfo(),
        ),
      ),
    );
  }

  Widget bodyProfileInfo() {
    return Builder(
      builder: (context) {
        return StreamBuilder<LanguageOption?>(
            stream: _presenter.currentLanguage,
            builder: (context, snapshotLanguage) {
              if (snapshotLanguage.hasData) {
                return StreamBuilder<ProfileViewModel?>(
                  stream: _presenter.profileStream,
                  builder: (context, snapshotViewmodel) {
                    // if (snapshotViewmodel.hasError) {
                    //   showErrorDialog(context, error: '${snapshotViewmodel.error}', action: _presenter.loadPage);
                    // }

                    if (snapshotViewmodel.hasData) {
                      final profile = snapshotViewmodel.data;
                      final language = snapshotLanguage.data;

                      return ListenableProvider(
                        create: (_) => _presenter,
                        child: ProfileBody(
                          profile: profile!,
                          currentLanguage: language!,
                        ),
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            });
      },
    );
  }
}
