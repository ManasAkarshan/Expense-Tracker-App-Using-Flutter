import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { Food, Travel, Leisure, Work}

const categoryIcons  = {
  Category.Food : Icons.lunch_dining,
  Category.Travel : Icons.flight_takeoff,
  Category.Leisure : Icons.movie,
  Category.Work : Icons.work,
};

class Expense{
  Expense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}

class ExpenseBucket{
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
    : expenses = allExpenses.where((expense){
        return expense.category == category;
      }).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;
  }
}