import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  final String title;
  final String number;
  final Color colorNumber;

  DataItem({
    this.title,
    this.number,
    this.colorNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        Text(
          number,
          style: TextStyle(color: colorNumber ?? Colors.black),
        ),
      ],
    );
  }
}
