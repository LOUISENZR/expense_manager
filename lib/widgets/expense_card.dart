import 'package:flutter/material.dart';
import 'package:pemrograman_mobile/screens/manage_expense_screen.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          style: const TextStyle(
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
            const SizedBox(height: 8),
            Text('Category: ${expense.category}'),
            const SizedBox(height: 8),
            Text('Date: ${expense.formattedDate}'),
            const SizedBox(height: 8),
            Text('Description: ${expense.description}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onEdit();
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
