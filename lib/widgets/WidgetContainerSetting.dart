import 'package:flutter/material.dart';

class WidgetContainerSetting extends StatelessWidget {
  WidgetContainerSetting({this.name, this.icon_name, this.ontap});
  final String name;
  final String icon_name;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 5, 0.3),
                        // has the effect of extending the shadow
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 30,
          left: 65,
          child: Text(name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans-Bold",
                fontSize: 16.0,
                color: Color(0xff201f28),
              )),
        ),
        Positioned(
          top: 30,
          left: 30,
          child: Image.asset(
            icon_name,
            width: 19,
            height: 19,
          ),
        ),
        Positioned(
          top: 30,
          right: 30,
          child: GestureDetector(
            onTap: ontap,
            child: Image.asset(
              "assets/icon_setting.jpg",
              width: 19,
              height: 19,
            ),
          ),
        ),
      ],
    );
  }
}
