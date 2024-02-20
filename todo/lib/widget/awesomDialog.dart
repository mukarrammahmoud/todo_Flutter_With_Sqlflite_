import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

awesomdialog(
    BuildContext context, Function()? btnOkOnPress, String desc, String title) {
  return AwesomeDialog(
    dismissOnTouchOutside: false,
    dialogBackgroundColor: Colors.blueGrey.withOpacity(0.8),
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.topSlide,
    title: title,
    desc: desc,
    btnCancelOnPress: () {},
    btnOkOnPress: btnOkOnPress,
  ).show();
}

Future awesomdialogInfo(BuildContext context, String desc, String title) {
  return AwesomeDialog(
    autoHide: const Duration(seconds: 1),
    headerAnimationLoop: true,
    dismissOnTouchOutside: false,
    dialogBackgroundColor: Colors.blueGrey.withOpacity(0.7),
    context: context,
    dialogType: title == "Login" ? DialogType.error : DialogType.info,
    animType: AnimType.topSlide,
    title: title,
    desc: desc,
  ).show();
}
