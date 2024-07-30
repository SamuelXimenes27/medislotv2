import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';

class DropdownMenuCities extends StatefulWidget {
  final List<CityModel> items;
  final Function(CityModel?) citySelected;
  const DropdownMenuCities({Key? key, required this.items, required this.citySelected}) : super(key: key);

  @override
  State<DropdownMenuCities> createState() => _DropdownMenuCitiesState();
}

class _DropdownMenuCitiesState extends State<DropdownMenuCities> {
  List<CityModel> get _items => widget.items;
  CityModel? _itemSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BoxInputField(
        child: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('lib/ui/assets/imgs/icon_find_clinic.png', height: 20),
            const SizedBox(width: 5),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: DropdownButton<CityModel>(
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: _itemSelected == null
                      ? const Icon(Icons.keyboard_arrow_down_outlined)
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _itemSelected = null;
                              widget.citySelected(null);
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
                  hint: Text(R.string.location, style: const TextStyle(color: Colors.black45, fontSize: 14)),
                  items: _items.map((CityModel value) {
                    return DropdownMenuItem<CityModel>(
                      value: value,
                      child: Text(
                        value.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _itemSelected = value!;
                    widget.citySelected(value);
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
