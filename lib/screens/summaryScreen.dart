import 'package:controlgastos/models/expenseData.dart';
import 'package:controlgastos/screens/transactionFormScreen.dart';
import 'package:controlgastos/screens/transactionHistoryScreen.dart';
import 'package:controlgastos/widgets/expenseChart.dart';
import 'package:flutter/material.dart';

class Summaryscreen extends StatelessWidget {
  const Summaryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ExpenseData> expenseData = [ExpenseData(150, "Comida")];

    return Scaffold(
      appBar: AppBar(
        title: Text("Resumen de gastos"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (expenseData) => Transactionhistoryscreen())),
              icon: Icon(Icons.history))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resumen del Mes",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward_outlined, color: Colors.green),
                title: Text("Ingresos"),
                subtitle: Text('0.00€'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward_outlined, color: Colors.red),
                title: Text("Gastos"),
                subtitle: Text('0.00€'),
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Transactionformscreen(),
                    )),
                label: Text("Agregar transacción"),
                icon: Icon(Icons.add),
              ),
            ),
            // Expensechart(data: expenseData)
          ],
        ),
      ),
    );
  }
}
