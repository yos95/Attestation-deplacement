import 'package:flutter/material.dart';

class WidgetTextfield extends StatefulWidget {
  WidgetTextfield(
      {this.hintText,
      this.icon,
      this.OnChanged,
      this.typePassword,
      this.controller});
  final String hintText;
  final IconData icon;
  final Function OnChanged;
  final bool typePassword;
  final TextEditingController controller;

  @override
  _WidgetTextfieldState createState() => _WidgetTextfieldState();
}

class _WidgetTextfieldState extends State<WidgetTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
      child: TextField(
        controller: widget.controller,
        autofocus: false,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        obscureText: widget.typePassword,
        onChanged: widget.OnChanged,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              widget.icon,
              color: Color(0xff201F28),
            ),
          ),
          hintText: widget.hintText,
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
