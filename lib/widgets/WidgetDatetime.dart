import 'package:flutter/material.dart';

class WidgetDatetime extends StatelessWidget {
  WidgetDatetime(
      {this.text,
      this.OnPressed,
      this.colorBack,
      this.colorText,
      this.colorGradTwo,
      this.colorGradOne});
  final String text;
  final Function OnPressed;
  final Color colorBack;
  final Color colorText;
  final Color colorGradOne;
  final Color colorGradTwo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.only(left: 23, top: 10, right: 23, bottom: 10),
      child: FlatButton(
        padding: const EdgeInsets.all(0.0),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        onPressed: OnPressed,
        textColor: Colors.black,
        color: Colors.white,
        child: Container(
          width: double.infinity,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
              border: Border.all(
                width: 0,
                style: BorderStyle.none,
              ),
              color: Colors.white),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "OpenSans-Bold",
              fontSize: 22.33332824707031,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
