import 'dart:async';

import 'package:DovizCevirici/http/moneyapi.dart';
import 'package:DovizCevirici/model/money.dart';
import 'package:DovizCevirici/page/moneyconvert.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart' as display;
import 'showmoney.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Timer timer;
  HttpServer http;
  Widget body;
  TabController tabController;
  Future<Money> httpmoney;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    http = HttpServer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: afterInfoHome());
  }

  afterInfoHome() {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        bottom: TabBar(
          controller: tabController,
          tabs: [Tab(icon: Icon(Icons.cached)), Tab(icon: Icon(Icons.dvr))],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        ConvertMoney(http.getMoney()),
        GeneralMoney(http.getMoney())
      ]),
    );
  }
}
