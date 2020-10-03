import 'dart:convert';

Money moneyFromJson(String str) => Money.fromJson(json.decode(str));

String moneyToJson(Money data) => json.encode(data.toJson());

class Money {
  Money({
    this.rates,
    this.base,
    this.date,
  });

  Map<String, double> rates;
  String base;
  String date;

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        base: json["base"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "base": base,
        "date": date,
      };
}
