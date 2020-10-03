import 'package:flutter/material.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  var myController = TextEditingController();
  var myController2 = TextEditingController();

  factory Singleton() {
    return _singleton;
  }
  

  Singleton._internal();
}
