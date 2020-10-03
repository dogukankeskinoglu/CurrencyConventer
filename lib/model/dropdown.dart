import 'package:flutter/material.dart';

class CustomDropDown {
  List<String> _key;
  List<double> _value;
  double _dropdownvalue;
  Key _uniquekey;
  //String dropdownhint;

  CustomDropDown(this._key, this._value, this._uniquekey, this._dropdownvalue);

  getKey() => _key;
  getValue() => _value;
  getDropDownValue() => _dropdownvalue;
  getUniqueKey() => _uniquekey;

  setKey(key) => _key = key;
  setValue(value) => _value = value;
  setDropDownValue(dropdownvalue) => _dropdownvalue = dropdownvalue;
  setUniqueKey(uniquekey) => _uniquekey = uniquekey;
}
