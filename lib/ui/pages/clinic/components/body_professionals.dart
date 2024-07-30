import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../components/components.dart';

class BodyProfessionals extends StatefulWidget {
  final List<ProfessionalEntity> professionals;
  final List<SpecialityEntity> specialties;
  const BodyProfessionals({
    Key? key,
    required this.professionals,
    required this.specialties,
  }) : super(key: key);

  @override
  State<BodyProfessionals> createState() => _BodyProfessionalsState();
}

class _BodyProfessionalsState extends State<BodyProfessionals> {
  List<ProfessionalEntity> get _professionals => widget.professionals;
  List<SpecialityEntity> get _specialties => widget.specialties;

  late SpecialityEntity? _itemSelected;

  late List<ProfessionalEntity> professionalsBySpecialty;

  void mapProfessionalBySpecialty() {
    professionalsBySpecialty = _professionals.where((element) => element.specialties!.contains(_itemSelected)).toList();
  }

  @override
  void initState() {
    _itemSelected = _specialties.first;
    mapProfessionalBySpecialty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          R.string.healthProfessionals,
          style: textTheme.headline6!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        buildProfessionalDropdown(),
        professionalsBySpecialty.isEmpty
            ? SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(R.string.noProfessionalFound),
                ),
              )
            : SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: professionalsBySpecialty.length,
                  itemBuilder: (context, index) {
                    final item = professionalsBySpecialty[index];
                    return buildItemProfessional(item);
                  },
                ),
              )
      ],
    );
  }

  Widget buildProfessionalDropdown() {
    final width = MediaQuery.of(context).size.width / 1.5;

    return BoxInputField(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: DropdownButton<SpecialityEntity>(
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            value: _itemSelected,
            borderRadius: BorderRadius.circular(10),
            isDense: true,
            hint: Text(R.string.specialty, style: const TextStyle(color: Color(0xffb1b1b1), fontSize: 14)),
            items: _specialties.map((SpecialityEntity value) {
              return DropdownMenuItem<SpecialityEntity>(
                value: value,
                child: Text(value.name, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _itemSelected = value;
                mapProfessionalBySpecialty();
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildItemProfessional(ProfessionalEntity item) {
    final nameSplit = item.name.split(' ');

    final name = '${nameSplit[0]} ${nameSplit[1]} ${nameSplit.last}';

    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 143,
            height: 171,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: item.photo == '' || item.photo == ''
                  ? Image.asset(
                      'lib/ui/assets/imgs/image_without_photo.png',
                      fit: BoxFit.fitHeight,
                    )
                  : Image.network(
                      item.photo!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
