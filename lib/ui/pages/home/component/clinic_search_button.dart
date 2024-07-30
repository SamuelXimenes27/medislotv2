import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/data.dart';
import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class ClinicSearchButton extends StatefulWidget {
  final DateTime? dateTime;
  final CityModel? citySelected;
  final SpecialityModel? specialtySelected;
  const ClinicSearchButton({
    Key? key,
    required this.dateTime,
    required this.citySelected,
    required this.specialtySelected,
  }) : super(key: key);

  @override
  State<ClinicSearchButton> createState() => _ClinicSearchButtonState();
}

class _ClinicSearchButtonState extends State<ClinicSearchButton> {
  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<HomePresenter>(context);
    return StreamBuilder<bool>(
      stream: _presenter.isSearchLoadingStream,
      builder: (context, snapshotSearchLoading) {
        bool isLoading = snapshotSearchLoading.hasData && snapshotSearchLoading.data == true;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return StreamBuilder<List<HomeSearchClinicViewmodel>>(
            stream: _presenter.searchClinicsStream,
            builder: (context, snapshotResultSearch) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await _presenter.searchClinics(
                      SearchClinicsParams(
                        datetime: widget.dateTime,
                        citySelected: widget.citySelected,
                        specialtySelected: widget.specialtySelected,
                      ),
                    );
                  },
                  child: Text(R.string.search),
                ),
              );
            },
          );
        }
      },
    );
  }
}
