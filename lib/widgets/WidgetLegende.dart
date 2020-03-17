import 'package:flutter/material.dart';

class WidgetLegende extends StatelessWidget {
  WidgetLegende(
      {this.backgroundColor,
      this.borderColor,
      this.textLegende,
      this.textLegendeColor});
  final String textLegende;
  final Color borderColor, textLegendeColor, backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8, left: 8, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor,
            width: 2,
          )),
      child: Text(
        textLegende,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "OpenSans-Bold",
          fontSize: 8.833330154418945,
          color: textLegendeColor,
        ),
      ),
    );
  }
}
