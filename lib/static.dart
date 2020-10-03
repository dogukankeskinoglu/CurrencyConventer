import 'package:DovizCevirici/model/dropdown.dart';
import 'package:flutter/material.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  double dropdownvalue1 = 1;
  double dropdownvalue2 = 1;
  CustomDropDown dropdown1;
  CustomDropDown dropdown2;
  List<String> key;
  List<double> value;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}
