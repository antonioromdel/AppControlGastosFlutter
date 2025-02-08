enum TransactionsTypes { income, expense }

class Transaction {
  final String id;
  final String category;
  final double amount;
  final TransactionsTypes type;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.category,
      required this.amount,
      required this.type,
      required this.date});
}
