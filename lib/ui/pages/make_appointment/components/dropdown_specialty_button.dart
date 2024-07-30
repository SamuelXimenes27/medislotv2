import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';

class DropdownSpecialtyButton extends StatefulWidget {
  final ClinicEntity clinic;
  final Function(SpecialityEntity?) onSelectSpecialty;
  final Function(bool) isVideoAvailable;
  final Function(List<ProfessionalEntity>?) professionalsBySpecialtySelected;
  final Function(ProfessionalEntity?) professionalSelected;
  const DropdownSpecialtyButton({
    Key? key,
    required this.clinic,
    required this.onSelectSpecialty,
    required this.isVideoAvailable,
    required this.professionalsBySpecialtySelected,
    required this.professionalSelected,
  }) : super(key: key);

  @override
  State<DropdownSpecialtyButton> createState() => _DropdownSpecialtyButtonState();
}

class _DropdownSpecialtyButtonState extends State<DropdownSpecialtyButton> {
  ClinicEntity get _clinic => widget.clinic;

  SpecialityEntity? _specialtySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        isThreeLine: true,
        title: Text(R.string.specialty),
        subtitle: DropdownButton<SpecialityEntity>(
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          value: _specialtySelected,
          borderRadius: BorderRadius.circular(10),
          isDense: true,
          hint: Text(R.string.select, style: const TextStyle(color: Color(0xffb1b1b1), fontSize: 14)),
          selectedItemBuilder: (BuildContext context) {
            return _clinic.specialities!.map<Widget>((SpecialityEntity item) {
              return Container(
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(minWidth: 100),
                child: Text(
                  item.name,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              );
            }).toList();
          },
          items: _clinic.specialities!.map((SpecialityEntity value) {
            return DropdownMenuItem<SpecialityEntity>(
              value: value,
              child: Text(value.name, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _specialtySelected = value;
              widget.onSelectSpecialty(_specialtySelected);
              widget.isVideoAvailable(_specialtySelected!.video!);
              widget.professionalSelected(null);
              widget.professionalsBySpecialtySelected(
                  _clinic.professionals?.where((e) => e.specialties?.contains(_specialtySelected) ?? false).toList());
            });
          },
        ),
      ),
    );
  }
}
