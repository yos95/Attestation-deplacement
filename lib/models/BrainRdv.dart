import 'dart:core';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();

class brain {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('boolValue');
    return boolValue;
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue');
    return intValue;
  }

  getDoubleValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = prefs.getDouble('doubleValue');
    return doubleValue;
  }
}
