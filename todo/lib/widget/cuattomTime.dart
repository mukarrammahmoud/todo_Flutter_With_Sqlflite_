import 'package:flutter/material.dart';
import 'package:todo/widget/CusttomText.dart';

class CusttomTimeDialog extends StatefulWidget {
  const CusttomTimeDialog({super.key, required this.title});
  final String title;

  @override
  State<CusttomTimeDialog> createState() => _CusttomTimeDialogState();
}

String? fTime = "${currentTime!.hour} : ${currentTime!.minute}";
String? tTime = "${currentTime!.hour} : ${currentTime!.minute}";
TimeOfDay? time;
TimeOfDay? currentTime = TimeOfDay.now();

class _CusttomTimeDialogState extends State<CusttomTimeDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        Expanded(flex: 2, child: custtomText(widget.title)),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.timer,
                        color: Colors.green,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value == null) return;
                          setState(() {
                            time = value;
                            if (widget.title == "To:" ||
                                widget.title == "Time :") {
                              tTime = "${time!.hour}:${time!.minute}";
                            }
                            if (widget.title == "From:") {
                              fTime = "${time!.hour}:${time!.minute}";
                            }
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(time == null
                          ? "${currentTime!.hour} : ${currentTime!.minute}"
                          : "${time!.hour} : ${time!.minute}"))
                ]),
          ),
        ),
      ]),
    );
  }
}
