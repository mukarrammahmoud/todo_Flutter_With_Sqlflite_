import 'package:flutter/material.dart';

Widget custtomText(String title) {
  return Text(
    title,
    style: const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.amberAccent, fontSize: 16),
  );
}

Widget custtomTextSubTitle(String title) {
  return Container(
    child: Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      overflow: TextOverflow.ellipsis,
    ),
  );
}
