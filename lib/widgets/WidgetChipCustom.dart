import 'package:flutter/material.dart';

class WidgetChipCustom extends StatefulWidget {
  WidgetChipCustom({this.textLegende});

  final String textLegende;

  @override
  _WidgetChipCustomState createState() => _WidgetChipCustomState();
}

class _WidgetChipCustomState extends State<WidgetChipCustom> {
  String select;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          select = this.widget.textLegende;
          print(select);
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8, left: 3),
        padding: EdgeInsets.only(right: 15, left: 15, top: 6),
        decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                select == this.widget.textLegende
                    ? Color(0xFF50BEE4)
                    : Colors.transparent,
                select == this.widget.textLegende
                    ? Color(0xFFAB3A85)
                    : Colors.transparent
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: select == this.widget.textLegende
                  ? Colors.transparent
                  : Colors.black12,
              width: 1,
            )),
        child: Text(
          widget.textLegende,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans-Bold",
            fontSize: 8.833330154418945,
            color:
                select == this.widget.textLegende ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
