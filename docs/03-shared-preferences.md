# Flutter Authentication & Session Management with Shared Preferences

## Overview
This document outlines the implementation of a complete user authentication flow, including registration, login, and session persistence using the `shared_preferences` package. We will also cover protecting routes and refactoring UI components into custom widgets.

## What We Will Implement
- **User Data Model**: A class to represent a user with fullname, email, and username.
- **Form Validation**: Robust validation for login and registration forms.
- **Registration & Login Screens**: Implementing the UI and logic for user authentication.
- **Session Persistence**: Using `shared_preferences` to keep users logged in.
- **Custom Expense Widget**: Refactoring the expense item UI into a reusable widget.

## Theoretical Background

### 1. Form Validation in Flutter
Flutter provides a robust way to validate user input using the `Form` widget, `GlobalKey<FormState>`, and the `validator` property of `TextFormField`s.

### 2. Widget Composition
Breaking down complex UI into smaller, reusable widgets is a core principle in Flutter. This improves readability, maintainability, and reusability.

### 3. User Data Model & Shared Preferences
As discussed previously.

## Implementation Details

### 1. User Data Model

The `User` class will be updated to include `fullname` and `email`.

```dart
class User {
  final String fullname;
  final String email;
  final String username;
  final String password;

  User({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
  });
}
```

### 2. Registration & Login Logic with Form Validation
The authentication screens will use a `Form` with a `GlobalKey` to manage validation for all fields, as previously described.

### 3. Custom Widget for Expense Item

To improve code organization and reusability in `lib/screens/expense_list_screen.dart`, we will extract the UI for a single expense item into its own stateless widget.

#### Creating `ExpenseCard` Widget
This widget will receive an `Expense` object and be responsible for rendering the `Card` and `ListTile` with all associated styling and logic.

```dart
// In a new file, e.g., lib/widgets/expense_card.dart
import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(expense.category),
          child: Icon(_getCategoryIcon(expense.category), color: Colors.white, size: 20),
        ),
        title: Text(expense.title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('${expense.category} | ${expense.formattedDate}'),
        trailing: Text(expense.formattedAmount, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[600])),
        onTap: () => _showExpenseDetails(context, expense),
      ),
    );
  }

  // Helper methods like _getCategoryColor, _getCategoryIcon, 
  // and _showExpenseDetails would be moved here or to a utility file.
}
```

#### Simplifying `ListView.builder`
By using the new widget, the `itemBuilder` in `ExpenseListScreen` becomes much cleaner and more readable.

```dart
// In lib/screens/expense_list_screen.dart
ListView.builder(
  padding: EdgeInsets.all(8),
  itemCount: expenses.length,
  itemBuilder: (context, index) {
    return ExpenseCard(expense: expenses[index]); // Use the custom widget
  },
)
```

### 4. Session Checking and Logout
This logic remains the same.

## Implementation Plan

1.  **Update User Model**: Modify `lib/models/user.dart` to include `fullname` and `email` fields.
2.  **Implement Form Validation on Register Screen**:
    *   Wrap the fields in `lib/screens/register_screen.dart` with a `Form` widget and assign a `GlobalKey<FormState>`.
    *   Use `TextFormField`s with validators for all fields.
    *   Trigger validation in the `_register` method.
3.  **Implement Form Validation on Login Screen**:
    *   Apply the same `Form` validation pattern to `lib/screens/login_screen.dart`.
4.  **Refactor Expense Screen with Custom Widget**:
    *   Create a reusable `ExpenseCard` widget in a new file (`lib/widgets/expense_card.dart`).
    *   Move the UI logic for a single expense item from `expense_list_screen.dart` into `ExpenseCard`.
    *   Update the `ListView.builder` in `expense_list_screen.dart` to use the new `ExpenseCard` widget.
5.  **Update `main.dart`**: Ensure the initial route logic correctly directs users based on their login status.
