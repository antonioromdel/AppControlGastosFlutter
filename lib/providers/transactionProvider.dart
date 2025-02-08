import 'package:flutter/material.dart';
import 'package:controlgastos/models/transaction.dart';

class Transactionprovider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(String transactionId) {
    _transactions.removeWhere((transaction) => transaction.id == transactionId);
    notifyListeners();
  }
}
