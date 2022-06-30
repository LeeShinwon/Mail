import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({Key? key, required this.icon, required this.title}) : super(key: key);
  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(title),
      ],
    );
  }
}
