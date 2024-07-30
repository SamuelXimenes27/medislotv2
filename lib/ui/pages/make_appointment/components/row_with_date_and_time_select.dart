import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../domain/entities/clinic_entity.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class RowWithDateAndTimeSelected extends StatefulWidget {
  final ClinicEntity clinic;
  final Function(DateTime?) dateSeleted;
  final Function(String?) timeOfDaySelected;
  const RowWithDateAndTimeSelected({
    Key? key,
    required this.clinic,
    required this.dateSeleted,
    required this.timeOfDaySelected,
  }) : super(key: key);

  @override
  State<RowWithDateAndTimeSelected> createState() => _RowWithDateAndTimeSelectedState();
}

class _RowWithDateAndTimeSelectedState extends State<RowWithDateAndTimeSelected> {
  ClinicEntity get _clinic => widget.clinic;
  DateTime? _dateSelected;
  String? _timeOfDaySelected;

  final List<int> weekDaysAvailable = [];

  Future<void> _selectDate(BuildContext context, MakeAppointmentPresenter presenter) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        selectableDayPredicate: (DateTime dateTime) => weekDaysAvailable.contains(dateTime.weekday));
    if (picked != null && picked != _dateSelected) {
      setState(() {
        _dateSelected = picked;
        widget.dateSeleted(_dateSelected);
      });
    }
  }

  _setUpWeekDaysAvailable() {
    _clinic.schedule!.removeWhere((element) => element.isEmpty);
    _clinic.schedule?.forEach((element) {
      weekDaysAvailable.add(element.first.weekday + 1);
    });
  }

  @override
  void initState() {
    _setUpWeekDaysAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _presenter = Provider.of<MakeAppointmentPresenter>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _listTileDate(_presenter),
        ),
        Expanded(
          child: StreamBuilder<List<String>>(
            stream: _presenter.professionalSlots,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (!snapshot.data!.contains(_timeOfDaySelected)) {
                  _timeOfDaySelected = null;
                }
                return dropdownButtonHours(snapshot.data ?? []);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget dropdownButtonHours(List<String> slots) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        isThreeLine: true,
        title: Text(R.string.openingHour),
        subtitle: Column(
          children: [
            DropdownButton<String>(
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              value: _timeOfDaySelected,
              borderRadius: BorderRadius.circular(10),
              isDense: true,
              underline: const SizedBox.shrink(),
              hint: Text(R.string.select, style: const TextStyle(color: Color(0xffb1b1b1), fontSize: 14)),
              selectedItemBuilder: (BuildContext context) {
                return slots.map<Widget>((String item) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  );
                }).toList();
              },
              items: slots.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _timeOfDaySelected = value;
                  widget.timeOfDaySelected(_timeOfDaySelected);
                });
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _listTileDate(MakeAppointmentPresenter presenter) {
    return GestureDetector(
      onTap: () => _selectDate(context, presenter),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          title: Text(R.string.date),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _dateSelected == null ? R.string.select : DateFormat("dd/MM/yyyy").format(_dateSelected!),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
