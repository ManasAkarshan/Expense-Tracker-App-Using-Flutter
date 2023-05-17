import 'package:flutter/material.dart';
import 'package:three_expense_tracker_app/widgets/expenses_list/expense_item.dart';

import '../../models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, 
      itemBuilder: (context, index){
        return Dismissible(                          // Returns cards
          key: ValueKey(expenses[index]),
          onDismissed: (direction){
            onRemoveExpense(expenses[index]);
          },
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          ),
          child: ExpenseItem(expenses[index])
        );
      }
    );
  }
}