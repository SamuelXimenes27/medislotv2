import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../domain/entities/clinic_entity.dart';
import '../../../ui/mixins/mixins.dart';

class MakeAppointmentPage extends StatefulWidget {
  final MakeAppointmentPresenter presenter;
  const MakeAppointmentPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<MakeAppointmentPage> createState() => _MakeAppointmentPageState();
}

class _MakeAppointmentPageState extends State<MakeAppointmentPage>
    with
        LoadingManager,
        NavigationManager,
        SessionManager,
        RouteAware,
        UIErrorManager {
  MakeAppointmentPresenter get _presenter => widget.presenter;

  @override
  void initState() {
    super.initState();
    handleMainError(context, _presenter.mainErrorStream, () {
      Get.back();
      return Future.value(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(context, title: R.string.makeAnAppointment,
          onPressed: () {
        Get.back();
      }),
      body: Builder(
        builder: (context) {
          handleSessionExpired(_presenter.isSessionExpiredStream);
          handleNavigation(_presenter.navigateToStream);
          _presenter.loadClinic();

          return StreamBuilder<ClinicEntity?>(
            stream: _presenter.clinicStream,
            builder: (context, snapshot) {
              // if (snapshot.hasError) {
              //   showErrorDialog(context, error: '${snapshot.error}', action: () => _presenter.loadClinic());
              // }

              if (snapshot.hasData) {
                final _clinic = snapshot.data!;
                return ListenableProvider(
                    create: (_) => _presenter,
                    child: PageBodyComponent(clinic: _clinic));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
