import 'package:flutter/material.dart';

class CusttomFloatingButton extends StatelessWidget {
  const CusttomFloatingButton({super.key, this.onPressed, required this.icon, required this.selItem});
  final void Function()? onPressed;
  final Icon icon;
  final int selItem;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: selItem==1?false:true,
      child: FloatingActionButton(
        onPressed: onPressed,
        splashColor: Colors.red,
        child: icon,
      ),
    );
  }
}
