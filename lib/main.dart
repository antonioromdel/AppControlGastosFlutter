import 'package:controlgastos/providers/transactionProvider.dart';
import 'package:controlgastos/screens/summaryScreen.dart';
import 'package:controlgastos/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Transactionprovider())],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Control de gastos",
      theme: Apptheme.lightTeme,
      home: Summaryscreen(),
    );
  }
}
