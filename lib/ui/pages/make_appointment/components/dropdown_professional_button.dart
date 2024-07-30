import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';

class DropdownProfessionalButton extends StatefulWidget {
  final List<ProfessionalEntity>? professionalsBySpecialtySelected;
  final void Function(ProfessionalEntity?) onSelected;
  final ProfessionalEntity? professionalSelected;
  const DropdownProfessionalButton({
    Key? key,
    required this.onSelected,
    required this.professionalSelected,
    this.professionalsBySpecialtySelected,
  }) : super(key: key);

  @override
  State<DropdownProfessionalButton> createState() => _DropdownProfessionalButtonState();
}

class _DropdownProfessionalButtonState extends State<DropdownProfessionalButton> {
  List<ProfessionalEntity>? get _professionalsBySpecialtySelected => widget.professionalsBySpecialtySelected;
  ProfessionalEntity? get _professionalSelected => widget.professionalSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        isThreeLine: true,
        title: Text(R.string.professional),
        subtitle: DropdownButton<ProfessionalEntity>(
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          value: _professionalSelected,
          borderRadius: BorderRadius.circular(10),
          isDense: true,
          hint: Text(
              _professionalsBySpecialtySelected?.isEmpty == true
                  ? R.string.thereIsNoProfessionalForThisSpecialty
                  : R.string.select,
              style: const TextStyle(color: Color(0xffb1b1b1), fontSize: 14)),
          selectedItemBuilder: (BuildContext context) {
            if (_professionalsBySpecialtySelected?.isNotEmpty == true) {
              return _professionalsBySpecialtySelected!.map<Widget>((ProfessionalEntity item) {
                return Container(
                  alignment: Alignment.centerLeft,
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Text(
                    item.name,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                );
              }).toList();
            }
            return [];
          },
          items: _professionalsBySpecialtySelected?.isNotEmpty == true
              ? _professionalsBySpecialtySelected!.map((ProfessionalEntity value) {
                  return DropdownMenuItem<ProfessionalEntity>(
                    value: value,
                    child: Text(value.name, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
                  );
                }).toList()
              : [],
          onChanged: (value) {
            setState(() {
              widget.onSelected(value);
            });
          },
        ),
      ),
    );
  }
}
