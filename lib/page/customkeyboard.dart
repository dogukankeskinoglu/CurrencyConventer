import 'package:DovizCevirici/static.dart';
import 'package:flutter/material.dart';

class MyKeyboard extends StatelessWidget {
  Singleton sing = Singleton();
  List<dynamic> keyboardNumber = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    ".",
    "0",
    "-1",
  ];
  @override
  Widget build(BuildContext context) {
    TextEditingController con1 = sing.myController;
    TextEditingController con2 = sing.myController2;

    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(color: Colors.cyan[50], boxShadow: [
        BoxShadow(spreadRadius: 2, blurRadius: 5, color: Colors.blue[100])
      ]),
      child: GridView.builder(
        cacheExtent: 1,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.8),
        ),
        itemCount: keyboardNumber.length,
        itemBuilder: (context, index) => InkWell(
          child: Container(

              //color: Colors.blue,
              child: Center(
                  child: keyboardNumber[index] != "-1"
                      ? Text(keyboardNumber[index].toString(),
                          style: TextStyle(fontSize: 22))
                      : Icon(Icons.backspace))),
          onTap: () {
            print(index.toString());
            switch (keyboardNumber[index]) {
              case "-1":
                if (con1.text.length != 0)
                  con1.text = con1.text.substring(0, con1.text.length - 1);
                else {
                  con2.text = "";
                }
                break;
              default:
                sing.myController.text += keyboardNumber[index].toString();
                break;
            }
          },
        ),
      ),
    );
  }
}
