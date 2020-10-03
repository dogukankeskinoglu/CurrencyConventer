import 'package:DovizCevirici/model/money.dart';
import 'package:DovizCevirici/static.dart';

import 'package:flutter/material.dart';

class GeneralMoney extends StatelessWidget {
  Map<String, double> map_;
  Future<Money> l;
  Singleton sing = new Singleton();

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
          sing.key = new_map.keys.toList();
          sing.key.sort((a, b) => a.compareTo(b));

          sing.value = sing.key.map((e) => new_map[e]).toList();

          return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(sing.key[index]),
                subtitle: Text(sing.value[index].toString()),
              ),
            ),
            itemCount: sing.key.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
