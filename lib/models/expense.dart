class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  String? description;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
  });

  String get formattedAmount => 'Rp ${amount.toStringAsFixed(0)}';

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }
}

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

void createExpense(Expense newExpense) {
  expenses.add(newExpense);
}

List<Expense> getExpenses() {
  return expenses;
}

void updateExpense(Expense updatedExpense) {
  final index = expenses.indexWhere(
    (expense) => expense.id == updatedExpense.id,
  );
  if (index != -1) {
    expenses[index] = updatedExpense;
  }
}

void deleteExpense(String expenseId) {
  expenses.removeWhere((expense) => expense.id == expenseId);
}
