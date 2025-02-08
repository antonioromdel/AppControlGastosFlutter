// import 'package:controlgastos/models/expenseData.dart';
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class Expensechart extends StatelessWidget {
//   final List<ExpenseData> data;
//   const Expensechart({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<ExpenseData, String>> series = [
//       charts.Series(
//           id: 'Gastos',
//           data: data,
//           domainFn: (ExpenseData expense, _) => expense.category,
//           measureFn: (ExpenseData expense, _) => expense.amount,
//           colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault)
//     ];

//     return Container(
//       padding: EdgeInsets.all(16),
//       height: 300,
//       child: charts.BarChart(
//         series,
//         animate: true,
//       ),
//     );
//   }
// }
