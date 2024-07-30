import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';

class BodyWithSpecialties extends StatefulWidget {
  final List<SpecialityEntity> specialties;
  const BodyWithSpecialties({Key? key, required this.specialties}) : super(key: key);

  @override
  State<BodyWithSpecialties> createState() => _BodyWithSpecialtiesState();
}

class _BodyWithSpecialtiesState extends State<BodyWithSpecialties> {
  bool isShowSeeAll = true;
  bool isSeeAll = false;
  List<SpecialityEntity> get _specialties => widget.specialties;

  @override
  void initState() {
    isShowSeeAll = _specialties.length <= 4 ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  R.string.specialties,
                  style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              if (isShowSeeAll)
                Expanded(
                  flex: 2,
                  child: TextButton(
                    style: ButtonStyle(
                      alignment: Alignment.centerRight,
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                    ),
                    child: Text(
                      isSeeAll ? R.string.close : R.string.seeAll,
                      style: textTheme.bodyText2!.copyWith(
                        color: colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSeeAll = !isSeeAll;
                      });
                    },
                  ),
                )
            ],
          ),
        ),
        if (!isShowSeeAll)
          const SizedBox(
            height: 5,
          ),
        SizedBox(
          height: isSeeAll ? 20.0 * _specialties.length : 80,
          width: double.infinity,
          child: ListView.builder(
            primary: false,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            itemCount: getCount(),
            itemBuilder: (context, index) {
              final item = _specialties[index];

              return Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.bodyText1!.copyWith(fontSize: 14),
                    ),
                    if (item.price != null && item.price != '0.00')
                      Text(item.price.toString(), style: textTheme.bodyText1!.copyWith(fontSize: 14)),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  int getCount() {
    if (_specialties.length <= 4) {
      return _specialties.length;
    } else {
      return isSeeAll ? _specialties.length : 4;
    }
  }
}
