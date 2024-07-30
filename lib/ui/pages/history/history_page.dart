import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../ui/mixins/mixins.dart';

class HistoryPage extends StatefulWidget {
  final HistoryPresenter presenter;
  const HistoryPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with LoadingManager, NavigationManager, SessionManager, RouteAware, UIErrorManager {
  HistoryPresenter get _presenter => widget.presenter;

  @override
  void initState() {
    handleLoading(context, _presenter.isLoadingStream);
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
        backgroundColor: colorScheme.background,
        appBar: buildDefaultAppBar(
          context,
          title: R.string.history,
          onPressed: () {
            Get.offNamed('/history');
            Get.back();
            Get.back();
          },
        ),
        body: Builder(
          builder: (context) {
            return StreamBuilder<List<HistoryItemViewmodel>>(
              stream: _presenter.historyStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final _history = snapshot.data;
                  return _buildPageWidgets(_history ?? []);
                }

                return Container();
              },
            );
          },
        ));
  }

  Widget _buildPageWidgets(List<HistoryItemViewmodel> history) {
    return history.isEmpty
        ? const Center(
            child: Text('Nenhum agendamento feito.'),
          )
        : ListenableProvider<HistoryPresenter>(
            create: (_) => _presenter,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 30),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];

                return HistoryItem(
                  item: item,
                );
              },
            ),
          );
  }
}
