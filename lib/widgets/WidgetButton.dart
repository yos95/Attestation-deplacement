import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  WidgetButton(
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
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.only(left: 23, top: 10, right: 23, bottom: 10),
      child: RaisedButton(
        padding: const EdgeInsets.all(0.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(
              width: 0,
              style: BorderStyle.none,
            )),
        onPressed: OnPressed,
        textColor: colorText,
        color: colorBack,
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 23, top: 10, right: 23, bottom: 10),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
              gradient: new LinearGradient(
                colors: [colorGradOne, colorGradTwo],
              )),
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
