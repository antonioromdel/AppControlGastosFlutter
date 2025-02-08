enum TransactionsTypes { income, expense }

class Transaction {
  final String id;
  final String category;
  final String description;
  final double amount;
  final TransactionsTypes type;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.category,
      required this.description,
      required this.amount,
      required this.type,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'amount': amount,
      'type': type == TransactionsTypes.income ? 'income' : 'expense',
      'date': date.toIso8601String()
    };
  }
}
