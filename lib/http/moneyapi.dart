import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:DovizCevirici/model/money.dart';

class HttpServer {
  Future<Money> getMoney() async {
    Money money;
    var response =
        await http.get("https://api.exchangeratesapi.io/latest?base=TRY");
    //debugPrint(response.body);
    //debugPrint(json.decode(response.body).toString());
    //debugPrint(json.decode(response.body)["date"].toString());
    //debugPrint(json.decode(response.body)["base"].toString());
    //debugPrint(json.decode(response.body)["rates"]["EUR"].toString());

    if (response.statusCode == 200) {
      //debugPrint("sa" + json.decode(response.body)["rates"]["EUR"].toString());
      money = Money.fromJson(json.decode(response.body));
      //debugPrint(money.date.toString());
      //debugPrint(money.base.toString());
      /*money.rates.forEach((key, value) {
        debugPrint(key.toString() + value.toString());
      });*/
      //debugPrint(money.rates_value);

      return money;
    } else {
      throw Exception("Bağlşanamadık");
    }
  }
}
