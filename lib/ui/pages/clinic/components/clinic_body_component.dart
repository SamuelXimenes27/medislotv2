import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/pages/pages.dart';

class ClinicBodyComponent extends StatelessWidget {
  final ClinicEntity clinic;
  const ClinicBodyComponent({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<ClinicPresenter>(context);

    return DraggableScrollableSheet(
      maxChildSize: 0.75,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.13),
                offset: const Offset(0, -4),
              )
            ],
            color: const Color(0xffF5F5F5),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  BodyRowWithNameAndRating(name: clinic.name, rating: clinic.rating),
                  ListenableProvider(create: (_) => _presenter, child: BodyRowWithAddress(clinic: clinic)),
                  const SizedBox(height: 5),
                  ListenableProvider(create: (_) => _presenter, child: BodyRowWithPhone(clinic: clinic)),
                  const SizedBox(height: 20),
                  BodyWithOpeningHour(schedules: clinic.schedule ?? []),
                  BodyWithSpecialties(specialties: clinic.specialities ?? []),
                  const SizedBox(height: 20),
                  BodyProfessionals(
                    professionals: clinic.professionals ?? [],
                    specialties: clinic.specialities ?? [],
                  ),
                  const SizedBox(height: 20),
                  BodyAgreementAndProtocols(insurers: clinic.insurers ?? []),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
