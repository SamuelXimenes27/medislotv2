import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../ui/mixins/mixins.dart';

class UpcomingPage extends StatefulWidget {
  final UpcomingPresenter presenter;
  const UpcomingPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage>
    with LoadingManager, NavigationManager, SessionManager, RouteAware, UIErrorManager {
  UpcomingPresenter get _presenter => widget.presenter;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    handleSessionExpired(_presenter.isSessionExpiredStream);
    handleNavigation(_presenter.navigateToStream);
    handleMainError(context, _presenter.mainErrorStream, () {
      Get.back();
      _presenter.loadPage();
      return Future.value(null);
    });
    _presenter.loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: buildDefaultAppBar(context, title: R.string.upcomingAppointments, onPressed: () {
        Get.offNamed('/upcoming');
        Get.back();
        Get.back();
      }),
      body: Builder(builder: (context) {
        return StreamBuilder<List<UpcomingViewmodel>>(
          stream: _presenter.upcomingStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _upcoming = snapshot.data;
              return _buildPageWidgets(_upcoming ?? []);
            }

            return const Center(child: CircularProgressIndicator());
          },
        );
      }),
    );
  }

  Widget _buildPageWidgets(List<UpcomingViewmodel> upcomigs) {
    return upcomigs.isEmpty
        ? const Center(
            child: Text('Nenhum agendamento feito.'),
          )
        : ListView.builder(
            padding: const EdgeInsets.only(top: 30),
            itemCount: upcomigs.length,
            itemBuilder: (context, index) {
              final item = upcomigs[index];
              final dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              final dateUpcoming = DateTime(item.dateTime.year, item.dateTime.month, item.dateTime.day);
              final isVideoAvailable = dateToday.isAtSameMomentAs(dateUpcoming);

              return GestureDetector(
                onTap: () => _presenter.goToClinicPage(item.clinicId),
                child: UpcomingItem(
                  presenter: _presenter,
                  upcomingViewmodel: item,
                  isVideo: item.video,
                  isVideoAvailable: isVideoAvailable,
                  scaffoldKey: _scaffoldKey,
                ),
              );
            },
          );
  }
}
