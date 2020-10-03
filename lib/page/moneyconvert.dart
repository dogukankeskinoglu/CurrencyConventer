import 'dart:convert';

import 'package:DovizCevirici/model/dropdown.dart';
import 'package:DovizCevirici/model/money.dart';
import 'package:DovizCevirici/page/customkeyboard.dart';
import 'package:DovizCevirici/static.dart';
import 'package:flutter/material.dart';

class ConvertMoney extends StatefulWidget {
  Future<Money> l;
  @override
  _ConvertMoneyState createState() => _ConvertMoneyState();

  ConvertMoney(this.l);
}

class _ConvertMoneyState extends State<ConvertMoney> {
  double d1value;
  double d2value;
  Key k0;
  Key k1;
  String dropdownhint;
  CustomDropDown d1;
  CustomDropDown d2;
  List<String> key;
  List<double> value;
  Singleton sing = new Singleton();
  TextEditingController myController;
  TextEditingController myController2;
  @override
  void initState() {
    super.initState();
    d1value = 1;
    d2value = 1;
    myController = sing.myController;
    myController2 = sing.myController2;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Stack(
        children: [
          getFirstStackItem(),
          getSecondStackItem(),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 25,
            left: 0,
            right: 0,
            child: MyKeyboard(),
          ),
          getThirdStackItem(),
          /**/
        ],
      ),
    );
  }

  getFutureBuilder() {
    return FutureBuilder(
      future: widget.l,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //debugPrint(snapshot.data);
          Map<String, double> new_map = Map.from(snapshot.data.rates).map((k,
                  v) =>
              MapEntry<String, double>(k, double.parse(v.toStringAsFixed(5))));
          key = new_map.keys.toList();
          key.sort((a, b) => a.compareTo(b));
          value = key.map((e) => new_map[e]).toList();
          //debugPrint(snapshot.data.rates["TRY"].toString());
          d1 = CustomDropDown(key, value, k0, d1value); //getDropDown(),
          d2 = CustomDropDown(key, value, k1, d2value);
          return Column(
            children: [
              Row(
                children: [
                  getDropDown(d1, 0),
                  getTextFormField(myController, true, "Para Miktari")
                ],
              ),
              Row(
                children: [
                  getDropDown(d2, 1),
                  getTextFormField(myController2, true, "Toplam Para")
                ],
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  guncelTutar() {
    if (myController.text == "") {
      setState(() {
        myController2.text = "";
      });
    } else {
      double guncelToplam = 0;
      guncelToplam = double.parse(myController.text) *
          (d2.getDropDownValue() / d1.getDropDownValue());
      setState(() {
        myController2.text = guncelToplam.toStringAsFixed(2);
      });
    }
  }

  getTextFormField(
      TextEditingController myController, bool readonly, hintText) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.all(2),
      child: TextFormField(
        controller: myController,
        readOnly: readonly,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red)),
          filled: true,
          fillColor: Colors.cyan[50],
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15),
          contentPadding: EdgeInsets.all(10),
        ),
        /*onChanged: (value) {
          print("sa");
          guncelTutar(value);
        },*/
      ),
    );
  }

  getDropDown(CustomDropDown cdropdown, int key) {
    List<String> dropdownkey = cdropdown.getKey();
    List<double> dropdownvalue = cdropdown.getValue();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<double>(
          value: cdropdown.getDropDownValue(),
          key: cdropdown.getUniqueKey(),

          //value: "sa",
          //disabledHint: Text("Parayı Seç"),
          items: dropdownkey
              .map((e) => DropdownMenuItem<double>(
                  child: Text(e.toString()),
                  value: dropdownvalue[dropdownkey.indexOf(e)]))
              .toList(),
          onChanged: (value) {
            setState(() {
              switch (key) {
                case 0:
                  d1value = value;
                  guncelTutar();
                  break;
                case 1:
                  d2value = value;
                  guncelTutar();
                  break;
              }
            });
          },
        ),
      ),
    );
  }

  getFirstStackItem() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      //color: Colors.blue,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        color: Colors.blue.shade400,
      ),
    );
  }

  getSecondStackItem() {
    return Positioned(
        top: MediaQuery.of(context).size.height / 10,
        left: 0,
        right: 0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[300],
                  spreadRadius: 1,
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: getFutureBuilder(),
          ),
        ));
  }

  getThirdStackItem() {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2.8,
      left: MediaQuery.of(context).size.width / 3,
      child: InkWell(
        onTap: () => guncelTutar(),
        child: Container(
          height: MediaQuery.of(context).size.height / 15,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ÇEVİR", style: TextStyle(color: Colors.white)),
              Icon(Icons.autorenew, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
