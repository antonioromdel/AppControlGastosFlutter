import 'package:controlgastos/models/transaction.dart';
import 'package:controlgastos/providers/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Transactionformscreen extends StatefulWidget {
  final Transaction? transaction;
  const Transactionformscreen({super.key, this.transaction});

  @override
  State<Transactionformscreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Transactionformscreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late TransactionsTypes _selectedType;
  bool _isEditing = false;

  final List<String> _categories = [
    "Comida",
    "Transporte",
    "Entretenimiento",
    "Suscripciones",
    "Casa",
    "Trabajo",
    "Otros"
  ];
  String _selectedCategoria = "Comida";

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      _isEditing = true;
      _amountController =
          TextEditingController(text: widget.transaction!.amount.toString());
      _descriptionController =
          TextEditingController(text: widget.transaction!.description);
      _selectedCategoria = widget.transaction!.category;
      _selectedType = widget.transaction!.type;
    } else {
      _amountController = TextEditingController();
      _descriptionController = TextEditingController();
      _selectedType = TransactionsTypes.expense;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _isEditing ? "Editar transacción" : "Registrar nueva transacción"),
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                          if (_isEditing) {
                            Provider.of<Transactionprovider>(context,
                                    listen: false)
                                .editTransaction(
                                    widget.transaction!.id,
                                    _amountController.text,
                                    _descriptionController.text,
                                    _selectedType,
                                    _selectedCategoria);
                          } else {
                            final newTransaction = Transaction(
                                id: Uuid().v4(),
                                category: _selectedCategoria,
                                description: _descriptionController.text,
                                amount: double.parse(_amountController.text),
                                type: _selectedType,
                                date: DateTime.now());

                            Provider.of<Transactionprovider>(context,
                                    listen: false)
                                .addTransaction(newTransaction);
                          }
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Transacción guardada")));
                        Navigator.pop(context);
                      },
                      child: Text(_isEditing
                          ? "Guardar cambios"
                          : "Guardar transacción")),
                )
              ],
            ),
          )),
    );
  }
}
