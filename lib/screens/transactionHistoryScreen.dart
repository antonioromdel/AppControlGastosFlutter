import 'package:controlgastos/models/transaction.dart';
import 'package:controlgastos/providers/transactionProvider.dart';
import 'package:controlgastos/screens/transactionFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Transactionhistoryscreen extends StatelessWidget {
  final TransactionsTypes? transactionType;
  const Transactionhistoryscreen({super.key, this.transactionType});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<Transactionprovider>(context);
    final transactions = transactionType != null
        ? transactionProvider.transactions
            .where((transaction) => transaction.type == transactionType)
            .toList()
        : transactionProvider.transactions;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Historial de transacciones"),
        ),
        body: transactions.isEmpty
            ? Center(child: Text("No hay transacciones realizadas"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "* Mantén pulsado sobre una transacción para eliminarla"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading:
                                  transaction.type == TransactionsTypes.income
                                      ? Icon(Icons.arrow_upward_outlined,
                                          color: Colors.green)
                                      : Icon(Icons.arrow_downward_outlined,
                                          color: Colors.red),
                              title: Text(transaction.description),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(DateFormat.yMMMd()
                                      .format(transaction.date)),
                                  Text(transaction.category)
                                ],
                              ),
                              trailing: Text(
                                '${transaction.amount.toStringAsFixed(2)}€',
                                style: TextStyle(
                                    color: transaction.type ==
                                            TransactionsTypes.income
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              onLongPress: () => _confirmDelete(
                                  context, transactionProvider, transaction.id),
                              onTap: () =>
                                  editTransaction(context, transaction),
                            ),
                          );
                        }),
                  )
                ],
              ));
  }
}

void editTransaction(context, Transaction transaction) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Transactionformscreen(transaction: transaction)));
}

void _confirmDelete(BuildContext context,
    Transactionprovider transactionProvider, String transactionid) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confimar eliminación"),
          content: Text("¿Seguro que deseas eliminar?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancelar")),
            TextButton(
                onPressed: () {
                  transactionProvider.deleteTransaction(transactionid);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Transacción eliminada")));
                  Navigator.of(context).pop();
                },
                child: Text("Sí, eliminar"))
          ],
        );
      });
}
