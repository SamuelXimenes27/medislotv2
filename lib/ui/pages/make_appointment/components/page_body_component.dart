import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class PageBodyComponent extends StatefulWidget {
  final ClinicEntity clinic;
  const PageBodyComponent({
    Key? key,
    required this.clinic,
  }) : super(key: key);

  @override
  State<PageBodyComponent> createState() => _PageBodyComponentState();
}

class _PageBodyComponentState extends State<PageBodyComponent> {
  ProfessionalEntity? _professionalSelected;
  SpecialityEntity? _specialtySelected;
  DateTime? _dateSelected;
  String? _timeOfDaySelected;
  bool? _videoOptionSelected;

  List<ProfessionalEntity>? professionalsBySpecialtySelected;

  bool _videoAvailable = false;

  ClinicEntity get _clinic => widget.clinic;

  bool showInfoDate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<MakeAppointmentPresenter>(context);

    return Builder(builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                foregroundImage: NetworkImage(_clinic.featuredImage!),
                radius: 60,
              ),
              _listTileClinic(),
              DropdownSpecialtyButton(
                clinic: _clinic,
                professionalSelected: (val) =>
                    setState(() => _professionalSelected = val),
                onSelectSpecialty: (val) =>
                    setState(() => _specialtySelected = val),
                isVideoAvailable: (val) =>
                    setState(() => _videoAvailable = val),
                professionalsBySpecialtySelected: (val) =>
                    setState(() => professionalsBySpecialtySelected = val),
              ),
              DropdownProfessionalButton(
                professionalSelected: _professionalSelected,
                professionalsBySpecialtySelected:
                    professionalsBySpecialtySelected,
                onSelected: (val) {
                  setState(() => _professionalSelected = val);
                },
              ),
              ListenableProvider(
                create: (_) => _presenter,
                child: AbsorbPointer(
                  absorbing: _professionalSelected == null &&
                      _specialtySelected == null,
                  child: RowWithDateAndTimeSelected(
                    clinic: _clinic,
                    dateSeleted: (dateTime) {
                      _dateSelected = dateTime;
                      _presenter.getAvailableSlots(
                          _professionalSelected!.id.toString(), _dateSelected!);
                      setState(() {});
                    },
                    timeOfDaySelected: (timeOfday) {
                      _timeOfDaySelected = timeOfday;
                      setState(() {});
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PriceTile(
                      specialtySelected: _specialtySelected,
                    ),
                  ),
                  Expanded(
                    child: VideoRadioButton(
                      isVideoAvailable: _videoAvailable,
                      isVideoOptionSelected: _videoOptionSelected,
                      onchanged: (val) {
                        setState(() {
                          _videoOptionSelected = val as bool;
                        });
                      },
                    ),
                  ),
                ],
              ),
              _buttonSubmit(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _buttonSubmit(BuildContext context) {
    final _presenter = Provider.of<MakeAppointmentPresenter>(context);

    final isDisable = _professionalSelected != null &&
        _specialtySelected != null &&
        _dateSelected != null;
    // _timeOfDaySelected != null;

    return ListenableProvider(
      create: (_) => _presenter,
      child: SubmitButton(
        isDisable: isDisable,
        onPressed: isDisable
            ? () async {
                final _hour = int.parse(_timeOfDaySelected!.split(':').first);
                final _minute = int.parse(_timeOfDaySelected!.split(':').last);

                final dateTimeOfAppointment = DateTime(_dateSelected!.year,
                    _dateSelected!.month, _dateSelected!.day, _hour, _minute);

                // final dateTimeOfAppointment = DateTime(2024, 04, 19, 16, 30);

                final checkoutParam = BookAppointmentParam(
                  specialtyId: _specialtySelected!.id,
                  professionalId: _professionalSelected!.id,
                  video: _videoOptionSelected == null ? false : true,
                  date: dateTimeOfAppointment,
                  name: '',
                  value: double.parse(_specialtySelected!.price!),
                );

                final isBooked =
                    await _presenter.bookAppointment(checkoutParam);

                if (isBooked) {
                  final checkout =
                      await _presenter.makeAppointment(checkoutParam);

                  final isPaymentComplete = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(checkout: checkout),
                    ),
                  );

                  Get.offAllNamed('/home');
                  Get.toNamed('/upcoming');

                  if (isPaymentComplete) {
                    const snackBar = SnackBar(
                      content: Text('Agendamento com sucesso'),
                      backgroundColor: Colors.green,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(R.string.paymentCancel),
                      backgroundColor: Colors.red,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              }
            : null,
      ),
    );
  }

  Widget _listTileClinic() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        isThreeLine: true,
        title: Text(R.string.clinic),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _clinic.name,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
