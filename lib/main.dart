// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticker/ticker.model.dart';
import 'package:ticker/ticker.ui.dart';
import 'package:ticker/support.gen.dart';

void main(List<String> args) {
  setupWindow(title: 'TFA: Ticker For Authors', windowHeight: 500, windowWidth: 500);

  runApp(
    ChangeNotifierProvider(
      create: (context) => Ticker(),
      child: const Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: TickerDisplay()),
    );
  }
}
