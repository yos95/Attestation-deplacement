import 'package:flutter/material.dart';

class WidgetTextfield extends StatelessWidget {
  WidgetTextfield(
      {this.hintText, this.icon, this.OnChanged, this.typePassword});
  final String hintText;
  final IconData icon;
  final Function OnChanged;
  final bool typePassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
      child: TextField(
        autofocus: false,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        obscureText: typePassword,
        onChanged: OnChanged,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              icon,
              color: Color(0xff201F28),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: "OpenSans-SemiBold",
            fontSize: 15,
            color: Color(0xff201f28),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.only(
            top: 13,
            bottom: 13,
          ),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
