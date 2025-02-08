import 'package:controlgastos/models/transaction.dart';
import 'package:controlgastos/providers/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Transactionformscreen extends StatefulWidget {
  const Transactionformscreen({super.key});

  @override
  State<Transactionformscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Transactionformscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TransactionsTypes _selectedType = TransactionsTypes.expense;

  final List<String> _categories = [
    "Comida",
    "Transporte",
    "Entretenimiento",
    "Otros"
  ];
  String _selectedCategoria = "Comida";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar transacción"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: "Cantidad"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, ingrese una cantidad";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Descripción"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, ingrese una descripción";
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                    value: _selectedCategoria,
                    decoration: InputDecoration(labelText: "Categoría"),
                    items: _categories
                        .map((category) => DropdownMenuItem(
                            value: category, child: Text(category)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategoria = value!;
                      });
                    }),
                Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                            title: Text("Gasto"),
                            value: TransactionsTypes.expense,
                            groupValue: _selectedType,
                            onChanged: (TransactionsTypes? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            })),
                    Expanded(
                        child: RadioListTile(
                            title: Text("Ingreso"),
                            value: TransactionsTypes.income,
                            groupValue: _selectedType,
                            onChanged: (TransactionsTypes? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            }))
                  ],
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newTransaction = Transaction(
                              id: Uuid().v4(),
                              category: _selectedCategoria,
                              amount: double.parse(_amountController.text),
                              type: _selectedType,
                              date: DateTime.now());

                          Provider.of<Transactionprovider>(context,
                                  listen: false)
                              .addTransaction(newTransaction);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Transacción guardada")));
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Guardar transacción")),
                )
              ],
            ),
          )),
    );
  }
}
