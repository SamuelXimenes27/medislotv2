import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/mixins/mixins.dart';
import '../../../../ui/pages/pages.dart';
import '../../components/components.dart';

class ClinicPage extends StatefulWidget {
  final ClinicPresenter presenter;

  const ClinicPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<ClinicPage> createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage>
    with LoadingManager, NavigationManager, SessionManager, RouteAware {
  ClinicPresenter get _presenter => widget.presenter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          onPressed: _presenter.makeAppointment,
          label: Text(
            R.string.makeAnAppointment,
            style: textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          )),
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
                return _buildPageWidgets(_clinic);
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

  Widget _buildPageWidgets(ClinicEntity clinic) {
    return Stack(
      children: [
        ClinicImageComponent(image: clinic.featuredImage),
        ButtonBackComponent(idPage: clinic.id),
        ListenableProvider(
            create: (_) => _presenter,
            child: ClinicBodyComponent(clinic: clinic)),
      ],
    );
  }
}
