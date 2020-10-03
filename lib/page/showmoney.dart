import 'package:DovizCevirici/model/money.dart';

import 'package:flutter/material.dart';

class GeneralMoney extends StatelessWidget {
  Map<String, double> map_;
  Future<Money> l;
  List<String> key_;
  List<double> value; //= new List<double>();

  GeneralMoney(this.l);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: l,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, double> new_map = Map.from(snapshot.data.rates).map((k,
                  v) =>
              MapEntry<String, double>(k, double.parse(v.toStringAsFixed(5))));
          key_ = new_map.keys.toList();
          key_.sort((a, b) => a.compareTo(b));

          value = key_.map((e) => new_map[e]).toList();

          return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(key_[index]),
                subtitle: Text(value[index].toString()),
              ),
            ),
            itemCount: key_.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
