import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Expense> expenses = [
      Expense(
        id: '1',
        title: 'Grocery Shopping',
        amount: 150000,
        category: 'Food',
        date: DateTime(2024, 9, 15),
        description: 'Weekly grocery shopping at supermarket',
      ),
      Expense(
        id: '2',
        title: 'Gas Station',
        amount: 50000,
        category: 'Transportation',
        date: DateTime(2024, 9, 14),
        description: 'Refuel motorcycle',
      ),
      Expense(
        id: '3',
        title: 'Coffee Shop',
        amount: 25000,
        category: 'Food',
        date: DateTime(2024, 9, 14),
        description: 'Morning coffee with friends',
      ),
      Expense(
        id: '4',
        title: 'Internet Bill',
        amount: 300000,
        category: 'Utilities',
        date: DateTime(2024, 9, 13),
        description: 'Monthly internet subscription',
      ),
      Expense(
        id: '5',
        title: 'Movie Tickets',
        amount: 100000,
        category: 'Entertainment',
        date: DateTime(2024, 9, 12),
        description: 'Weekend movie with family',
      ),
      Expense(
        id: '6',
        title: 'Book Purchase',
        amount: 75000,
        category: 'Education',
        date: DateTime(2024, 9, 11),
        description: 'Programming books for study',
      ),
      Expense(
        id: '7',
        title: 'Lunch',
        amount: 35000,
        category: 'Food',
        date: DateTime(2024, 9, 11),
        description: 'Lunch at restaurant',
      ),
      Expense(
        id: '8',
        title: 'Bus Fare',
        amount: 10000,
        category: 'Transportation',
        date: DateTime(2024, 9, 10),
        description: 'Daily commute to office',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(
                bottom: BorderSide(color: Colors.blue.shade200),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Total Expenses',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  _calculateTotal(expenses),
                  style: TextStyle(
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
              padding: EdgeInsets.all(8),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getCategoryColor(expense.category),
                      child: Icon(
                        _getCategoryIcon(expense.category),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      expense.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.category,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          expense.formattedDate,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      expense.formattedAmount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red[600],
                      ),
                    ),
                    onTap: () {
                      _showExpenseDetails(context, expense);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Add expense feature coming soon!')),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  String _calculateTotal(List<Expense> expenses) {
    double total = expenses.fold(0, (sum, expense) => sum + expense.amount);
    return 'Rp ${total.toStringAsFixed(0)}';
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Colors.orange;
      case 'transportation':
        return Colors.green;
      case 'utilities':
        return Colors.purple;
      case 'entertainment':
        return Colors.pink;
      case 'education':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'utilities':
        return Icons.home;
      case 'entertainment':
        return Icons.movie;
      case 'education':
        return Icons.school;
      default:
        return Icons.attach_money;
    }
  }

  void _showExpenseDetails(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(expense.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${expense.formattedAmount}'),
            SizedBox(height: 8),
            Text('Category: ${expense.category}'),
            SizedBox(height: 8),
            Text('Date: ${expense.formattedDate}'),
            SizedBox(height: 8),
            Text('Description: ${expense.description}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}