import 'package:flutter/material.dart';
import 'package:todo/widget/CusttomText.dart';

class CusttomFaild extends StatefulWidget {
  const CusttomFaild({
    super.key,
    required this.hintText,
    required this.title,
    required this.controller,
    
  });

  final String hintText;
  final String title;
  final TextEditingController controller;
 
  @override
  State<CusttomFaild> createState() => _CusttomFaildState();
}

class _CusttomFaildState extends State<CusttomFaild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: custtomText(widget.title),
          ),
          Expanded(
              flex: 3,
              child: TextFormField(
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Field Empty";
                  } else {
                    return null;
                  }
                },
                readOnly: widget.title == "Name :" ? true : false,
                maxLines:
                    widget.hintText == "Content" || widget.title == "Desc :"
                        ? 5
                        : 1,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide:
                          BorderSide(color: Color(0xff62fcd7), width: 2)),
                  hintText: widget.hintText,
                ),
              ))
        ],
      ),
    );
  }
}
