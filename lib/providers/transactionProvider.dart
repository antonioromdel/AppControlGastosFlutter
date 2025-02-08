import 'package:controlgastos/services/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:controlgastos/models/transaction.dart';

class Transactionprovider with ChangeNotifier {
  List<Transaction> _transactions = [];
  final Databasehelper _dbHelper = Databasehelper();

  List<Transaction> get transactions => _transactions;

  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    await _dbHelper.insertTransaction(transaction);
    notifyListeners();
  }

  void deleteTransaction(String transactionId) async {
    _transactions.removeWhere((transaction) => transaction.id == transactionId);
    await _dbHelper.deleteTransaction(transactionId);
    notifyListeners();
  }

  void editTransaction(String id, String amount, String description,
      TransactionsTypes type, String category) async {
    final transactionIndex =
        _transactions.indexWhere((transaction) => transaction.id == id);
    if (transactionIndex != -1) {
      _transactions[transactionIndex] = Transaction(
          id: id,
          category: category,
          description: description,
          amount: double.parse(amount),
          type: type,
          date: _transactions[transactionIndex].date);
      await _dbHelper.updateTransaction(_transactions[transactionIndex]);
      notifyListeners();
    }
  }
}
