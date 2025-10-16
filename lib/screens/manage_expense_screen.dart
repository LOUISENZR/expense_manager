import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pemrograman_mobile/models/expense.dart';

class ManageExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const ManageExpenseScreen({super.key, this.expense});

  @override
  State<ManageExpenseScreen> createState() => _ManageExpenseScreenState();
}

class _ManageExpenseScreenState extends State<ManageExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late double _amount;
  late String _category;
  late DateTime _date;
  late String _description;

  final List<String> _categories = [
    'Food',
    'Transportation',
    'Utilities',
    'Entertainment',
    'Education',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _title = widget.expense!.title;
      _amount = widget.expense!.amount;
      _category = widget.expense!.category;
      _date = widget.expense!.date;
      _description = widget.expense!.description!;
    } else {
      _title = '';
      _amount = 0;
      _category = _categories.first;
      _date = DateTime.now();
      _description = '';
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newExpense = Expense(
        id: widget.expense?.id ?? DateTime.now().toString(),
        title: _title,
        amount: _amount,
        category: _category,
        date: _date,
        description: _description,
      );
      if (widget.expense == null) {
        createExpense(newExpense);
      } else {
        updateExpense(newExpense);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? 'Add Expense' : 'Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _amount.toString(),
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items:
                    _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text('Date: ${DateFormat.yMd().format(_date)}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _date = pickedDate;
                        });
                      }
                    },
                    child: const Text('Choose Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveForm, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
