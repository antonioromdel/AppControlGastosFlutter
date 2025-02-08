import 'package:controlgastos/models/transaction.dart';
import 'package:controlgastos/providers/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Transactionhistoryscreen extends StatelessWidget {
  const Transactionhistoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<Transactionprovider>(context);
    final transactions = transactionProvider.transactions;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Historial de transacciones"),
        ),
        body: transactions.isEmpty
            ? Center(child: Text("No hay transacciones realizadas"))
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: transaction.type == TransactionsTypes.income
                          ? Icon(Icons.arrow_upward_outlined,
                              color: Colors.green)
                          : Icon(Icons.arrow_downward_outlined,
                              color: Colors.red),
                      title: Text(transaction.category),
                      subtitle:
                          Text(DateFormat.yMMMd().format(transaction.date)),
                      trailing: Text(
                        '${transaction.amount.toStringAsFixed(2)}€',
                        style: TextStyle(
                            color: transaction.type == TransactionsTypes.income
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      onLongPress: () {
                        transactionProvider.deleteTransaction(transaction.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Transacción eliminada")));
                      },
                    ),
                  );
                }));
  }
}
