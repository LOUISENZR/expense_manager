# Plan for Managing Expenses

This document outlines the plan to implement Create, Read, Update, and Delete (CRUD) functionality for expenses in the application. The `expenses` list in `lib/models/expense.dart` will be used as the data source.

## 1. Data Layer (Completed)

- **`createExpense(Expense newExpense)`:** Adds a new expense.
- **`getExpenses()`:** Retrieves all expenses.
- **`updateExpense(Expense updatedExpense)`:** Updates an existing expense.
- **`deleteExpense(String expenseId)`:** Removes an expense.

## 2. UI Implementation

### a. Manage Expense Screen (`lib/screens/manage_expense_screen.dart`)

- **Purpose:** A single screen for both creating and editing expenses.
- **Fields:**
  - Title (TextField)
  - Amount (TextField)
  - Category (Dropdown)
  - Date (DatePicker)
  - Description (TextField)
- **Actions:**
  - "Save" button to create or update an expense.

### b. Expense List Screen (`lib/screens/expense_list_screen.dart`)

- **FloatingActionButton:**
  - Navigates to `ManageExpenseScreen` to create a new expense.
- **Expense Card (`lib/widgets/expense_card.dart`):
  - **Edit Button:** Navigates to `ManageExpenseScreen` with the selected expense's data.
  - **Delete Button:** Calls `deleteExpense` and updates the list.

### c. Navigation

- **`lib/main.dart`:**
  - Add a route for `ManageExpenseScreen`.