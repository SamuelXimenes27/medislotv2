import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';

class BodyWithOpeningHour extends StatefulWidget {
  final List<List<ScheduleEntity>> schedules;
  const BodyWithOpeningHour({Key? key, required this.schedules}) : super(key: key);

  @override
  State<BodyWithOpeningHour> createState() => _BodyWithOpeningHourState();
}

class _BodyWithOpeningHourState extends State<BodyWithOpeningHour> {
  bool isSeeAll = false;
  List<List<ScheduleEntity>> get _schedules => widget.schedules;

  @override
  void initState() {
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
                  R.string.openingHour,
                  style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
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
        SizedBox(
          height: isSeeAll ? 170 : 40,
          width: double.infinity,
          child: ListView.builder(
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: isSeeAll ? _schedules.length : 1,
            itemBuilder: (context, index) {
              final item = _schedules[index];

              return Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      idToDate(index),
                      style: textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        fontWeight: index == DateTime.now().weekday - 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    item.isEmpty
                        ? Text(R.string.closed, style: textTheme.bodyText1!.copyWith(fontSize: 14))
                        : Text(mapOpeningHour(item),
                            style: textTheme.bodyText1!.copyWith(
                                fontSize: 14,
                                fontWeight: index == DateTime.now().weekday - 1 ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  String mapOpeningHour(List<ScheduleEntity> item) {
    if (item.length > 1) {
      return "${item.first.start} - ${item.first.end}    ${item.last.start} - ${item.last.end}";
    } else {
      return "${item.first.start} - ${item.first.end}";
    }
  }

  String idToDate(int id) {
    if (isSeeAll == false) {
      id = DateTime.now().weekday - 1;
    }

    switch (id) {
      case 0:
        return R.string.monday;
      case 1:
        return R.string.tuesday;
      case 2:
        return R.string.wednesday;
      case 3:
        return R.string.thursday;
      case 4:
        return R.string.friday;
      case 5:
        return R.string.saturday;
      default:
        return R.string.sunday;
    }
  }
}
