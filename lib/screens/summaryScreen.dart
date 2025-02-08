import 'package:controlgastos/models/transaction.dart';
import 'package:controlgastos/providers/transactionProvider.dart';
import 'package:controlgastos/screens/transactionFormScreen.dart';
import 'package:controlgastos/screens/transactionHistoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Summaryscreen extends StatefulWidget {
  const Summaryscreen({super.key});

  @override
  State<Summaryscreen> createState() => _SummaryscreenState();
}

class _SummaryscreenState extends State<Summaryscreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<Transactionprovider>(context, listen: false).loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<Transactionprovider>(context);
    final transactions = transactionProvider.transactions;

    double totalExpense = transactions.fold(0, (accum, transaction) {
      return transaction.type == TransactionsTypes.expense
          ? accum + transaction.amount
          : accum;
    });
    double totalIncome = transactions.fold(0, (accum, transaction) {
      return transaction.type == TransactionsTypes.income
          ? accum + transaction.amount
          : accum;
    });

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
            GestureDetector(
                child: Card(
                  child: ListTile(
                    leading:
                        Icon(Icons.arrow_upward_outlined, color: Colors.green),
                    title: Text("Ingresos"),
                    subtitle: Text('$totalIncome €'),
                  ),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Transactionhistoryscreen(
                              transactionType: TransactionsTypes.income,
                            )))),
            GestureDetector(
              child: Card(
                child: ListTile(
                  leading:
                      Icon(Icons.arrow_downward_outlined, color: Colors.red),
                  title: Text("Gastos"),
                  subtitle: Text('$totalExpense €'),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Transactionhistoryscreen(
                            transactionType: TransactionsTypes.expense,
                          ))),
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
