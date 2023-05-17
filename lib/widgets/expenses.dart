import 'package:flutter/material.dart';
import 'package:three_expense_tracker_app/widgets/chart/chart.dart';
import 'package:three_expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:three_expense_tracker_app/widgets/new_expense.dart';

import '../models/expense.dart';
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = 
  [
    Expense(
      title: 'Flutter Course',
      amount: 529 , date: DateTime.now(), 
      category: Category.Work
    ),
    Expense(
      title: 'Cinema',
      amount: 345.34 , date: DateTime.now(), 
      category: Category.Leisure,
    ),
  ];

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    var indexOfExpense = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registeredExpenses.insert(indexOfExpense, expense);
          });
        }),
      )
    );
  }

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,    // displays it in full screen
      context: context, 
      builder: (ctx){
        return NewExpense(_addExpense);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(child: Text('No expense found'));

    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpenseList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600 ?Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}