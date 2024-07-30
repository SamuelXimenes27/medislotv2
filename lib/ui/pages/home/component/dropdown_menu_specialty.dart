import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';

class DropdownMenuSpecialty extends StatefulWidget {
  final List<SpecialityModel> items;
  final Function(SpecialityModel?) itemSeleted;
  // final Function(SpecialityModel?)? onChanged;
  const DropdownMenuSpecialty({
    Key? key,
    required this.items,
    required this.itemSeleted,
    // required this.itemSeleted,
    // required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownMenuSpecialty> createState() => _DropdownMenuSpecialtyState();
}

class _DropdownMenuSpecialtyState extends State<DropdownMenuSpecialty> {
  List<SpecialityModel> get _items => widget.items;
  SpecialityModel? _itemSelected;
  // Function(SpecialityModel?)? get _onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) {
    return BoxInputField(
      child: Row(
        children: [
          const SizedBox(width: 10),
          Image.asset('lib/ui/assets/imgs/icon_medical_bag.png', height: 20),
          const SizedBox(width: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: DropdownButton<SpecialityModel>(
                isExpanded: true,
                underline: const SizedBox(),
                icon: _itemSelected == null
                    ? const Icon(Icons.keyboard_arrow_down_outlined)
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _itemSelected = null;
                            widget.itemSeleted(null);
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                value: _itemSelected,
                borderRadius: BorderRadius.circular(10),
                isDense: true,
                hint: Text(R.string.specialty, style: const TextStyle(color: Color(0xffb1b1b1), fontSize: 14)),
                items: _items.map((SpecialityModel value) {
                  return DropdownMenuItem<SpecialityModel>(
                    value: value,
                    child: Text(value.name, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _itemSelected = value;
                    widget.itemSeleted(value!);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
