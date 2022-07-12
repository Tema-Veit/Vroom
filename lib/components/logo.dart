import 'package:flutter/material.dart';

Widget Logo() {
  return const Padding(
    padding: EdgeInsets.only(top: 100),
    child: Align(
      child: Text(
        "VROOM",
        style: TextStyle(fontSize: 45, color: Colors.lightBlueAccent),
      ),
    ),
  );
}
