import 'package:flutter/material.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({
    super.key,
    this.onPressed,
    required this.title,
  });
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        color: Colors.green,
        child: Text(title),
      ),
    );
  }
}
