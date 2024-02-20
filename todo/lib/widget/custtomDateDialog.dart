import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/widget/CusttomText.dart';

class ShowDate extends StatefulWidget {
  const ShowDate({super.key});

  @override
  State<ShowDate> createState() => _ShowDateState();
}

String? selday;
String? date ;
DateTime selectDate = DateTime.now();

class _ShowDateState extends State<ShowDate> {
  String get day {
    if (DateFormat.EEEE().format(selectDate) == "Saturday") {
      selday = "السبت";
    }
    if (DateFormat.EEEE().format(selectDate) == "Sunday") {
      selday = "الأحد";
    }
    if (DateFormat.EEEE().format(selectDate) == "Monday") {
      selday = "الإثنين";
    }
    if (DateFormat.EEEE().format(selectDate) == "Tuesday") {
      selday = "الثلاثاء";
    }
    if (DateFormat.EEEE().format(selectDate) == "Wednesday") {
      selday = "الأربعاء";
    }
    if (DateFormat.EEEE().format(selectDate) == "Thursday") {
      selday = "الخميس";
    }
    if (DateFormat.EEEE().format(selectDate) == "Friday") {
      selday = "الجمعة";
    }

    return selday!;
  }

  @override
  Widget build(context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: custtomText("Date :"),
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                initialEntryMode: DatePickerEntryMode.calendar,
              ).then((value) {
                if (value == null) return;
                setState(() {
                  selectDate = value;
                  date = DateFormat.yMMMd().format(selectDate);
                  
                });
              });
            },
            child: Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: Colors.white)),
              child: Row(children: [
                Expanded(
                    child: Text(
                  DateFormat.yMMMd().format(selectDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                Expanded(
                  child: Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
