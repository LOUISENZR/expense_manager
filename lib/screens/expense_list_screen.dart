import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/screens/manage_expense_screen.dart';
import '../models/expense.dart';
import '../widgets/expense_card.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  late List<Expense> _expenses;

  @override
  void initState() {
    super.initState();
    _expenses = getExpenses();
  }

  void _navigateAndRefresh() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManageExpenseScreen()),
    );
    setState(() {
      _expenses = getExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(bottom: BorderSide(color: Colors.blue.shade200)),
            ),
            child: Column(
              children: [
                Text(
                  'Total Expenses',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Text(
                  _calculateTotal(_expenses),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return ExpenseCard(
                  expense: expense,
                  onEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageExpenseScreen(expense: expense),
                      ),
                    );
                    setState(() {
                      _expenses = getExpenses();
                    });
                  },
                  onDelete: () {
                    deleteExpense(expense.id);
                    setState(() {
                      _expenses = getExpenses();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndRefresh,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _calculateTotal(List<Expense> expenses) {
    double total = expenses.fold(0, (sum, expense) => sum + expense.amount);
    return 'Rp ${total.toStringAsFixed(0)}';
  }
}
