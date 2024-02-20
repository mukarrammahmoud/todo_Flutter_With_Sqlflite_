import 'package:flutter/material.dart';
import 'package:todo/widget/CusttomText.dart';

class CusttomDay extends StatefulWidget {
  const CusttomDay({super.key, required this.title,});
  final String title;
  
  @override
  State<CusttomDay> createState() => CusttomDayState();
}

String? selectedItem;

class CusttomDayState extends State<CusttomDay> {

 

  List DayOfWeek = ["Sat", "sun", "Mon", "Tue", "Wed", "Thu"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(flex: 1, child: custtomText(widget.title)),
          // Text(selectedItem!),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(left: 50),
              decoration: BoxDecoration(
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2)),
              child: DropdownButton(
                iconSize: 36,
                dropdownColor: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                underline: const Text(""),
                style: const TextStyle(color: Colors.white),
                value: selectedItem,
                items: DayOfWeek.map((e) {
                  return DropdownMenuItem(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem= value as String?;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
