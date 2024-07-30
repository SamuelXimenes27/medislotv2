import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../data/data.dart';
import '../../../domain/entities/clinic_entity.dart';
import '../../../ui/mixins/mixins.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        LoadingManager,
        NavigationManager,
        SessionManager,
        RouteAware,
        UIErrorManager {
  HomePresenter get _presenter => widget.presenter;

  SpecialityModel? specialtySelected;
  CityModel? citySelected;
  DateTime? dateTimeSelected;

  String nameForDrawer = "";

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    handleLoading(context, _presenter.isLoadingStream);
    handleSessionExpired(_presenter.isSessionExpiredStream);
    handleNavigation(_presenter.navigateToStream);
    handleMainError(context, _presenter.mainErrorStream, () {
      Get.back();
      _presenter.loadHomePage();
      return Future.value(null);
    });
    _presenter.loadHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<RouteObserver>()
        .subscribe(this, ModalRoute.of(context) as PageRoute);
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: ListenableProvider(
          create: (_) => _presenter,
          child: DrawerComponent(name: nameForDrawer)),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: ListView(
              children: [
                const SizedBox(height: 50),
                ListenableProvider(
                  create: (_) => _presenter,
                  child: Header(
                    openDrawer: () => _key.currentState!.openDrawer(),
                    nameForDrawer: (value) {
                      nameForDrawer = value;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  R.string.scheduleAppointment,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                builderSpecialities(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    DatepickerComponent(
                      dateTimeSelected: (value) {
                        dateTimeSelected = value;
                      },
                    ),
                    const SizedBox(width: 15),
                    builderCities(),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSearchButton(),
                const SizedBox(height: 40),
                Container(
                  height: 125,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          R.string.textTitleTriage,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () => _presenter.goToClinic('1'),
                          child: Text(R.string.triage),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    R.string.featureClinics,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                builderFeaturedClinics(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget builderSpecialities() {
    return Builder(
      builder: (context) {
        return StreamBuilder<List<SpecialityModel>>(
          stream: _presenter.specialitiesStream,
          builder: (context, snapshot) {
            // if (snapshot.hasError) {
            //   showErrorDialog(context, error: '${snapshot.error}', action: _presenter.loadHomePage);
            // }

            if (snapshot.hasData) {
              final items = snapshot.data;

              return DropdownMenuSpecialty(
                items: items!,
                itemSeleted: (value) {
                  specialtySelected = value;
                  setState(() {});
                },
              );
            }
            return Container();
          },
        );
      },
    );
  }

  Widget _buildSearchButton() {
    return ListenableProvider(
      create: (_) => _presenter,
      child: ClinicSearchButton(
        dateTime: dateTimeSelected,
        citySelected: citySelected,
        specialtySelected: specialtySelected,
      ),
    );
  }

  Widget builderCities() {
    return Builder(
      builder: (context) {
        return StreamBuilder<List<CityModel>>(
          stream: _presenter.citiesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownMenuCities(
                items: snapshot.data!,
                citySelected: (value) => citySelected = value,
              );
            }
            return Container();
          },
        );
      },
    );
  }

  Widget builderFeaturedClinics() {
    return Builder(
      builder: (context) {
        return StreamBuilder<List<ClinicEntity>>(
          stream: _presenter.featuredClinicStream,
          builder: (context, snapshot) {
            // if (snapshot.hasError) {
            //   showErrorDialog(context,
            //       error: '${snapshot.error}', action: _presenter.loadHomePage);
            // }

            if (snapshot.hasData) {
              final items = snapshot.data;
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: items!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return GestureDetector(
                      onTap: () => _presenter.goToClinic(item.id.toString()),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 222,
                              child: item.featuredImage == null
                                  ? Image.asset(
                                      'lib/ui/assets/imgs/logo_icon_simple.png')
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      child: Image.network(
                                        item.featuredImage!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(item.city!.isNotEmpty &&
                                    item.district!.isNotEmpty
                                ? '${item.city!.first.name}, ${item.district!.first.name}'
                                : ""),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
