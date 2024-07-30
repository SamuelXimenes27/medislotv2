import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';

class DatepickerComponent extends StatefulWidget {
  final Function(DateTime?) dateTimeSelected;
  const DatepickerComponent({
    Key? key,
    required this.dateTimeSelected,
  }) : super(key: key);

  @override
  State<DatepickerComponent> createState() => _DatepickerComponentState();
}

class _DatepickerComponentState extends State<DatepickerComponent> {
  final f = DateFormat('dd-MM-yy');
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dateTimeSelected(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: BoxInputField(
        width: 130,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset('lib/ui/assets/imgs/icon_timesheet.png', height: 20),
            const SizedBox(
              width: 5,
            ),
            Text(
              selectedDate == null ? R.string.date : f.format(selectedDate!).replaceAll('-', '/'),
              style: TextStyle(color: selectedDate == null ? const Color(0xffb9b9b9) : Colors.black, fontSize: 15),
            ),
            if (selectedDate != null) const Spacer(),
            if (selectedDate != null)
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = null;
                    widget.dateTimeSelected(null);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
