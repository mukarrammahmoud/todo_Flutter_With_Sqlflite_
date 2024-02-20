import 'package:flutter/material.dart';

class CusttomDivider extends StatelessWidget {
  const CusttomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Divider(
        thickness: 2,
        color: Colors.amber,
        height: 3,
      ),
    );
  }
}
