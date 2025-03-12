import 'package:expense_tracker_app/widgets/expanses_list/expanse_item.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpansesList extends StatelessWidget {
  const ExpansesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            background: Container(
              margin: Theme.of(context).cardTheme.margin,
              color: Theme.of(context).colorScheme.error,
            ),
            key: ValueKey(expenses[index]),
            child: ExpanseItem(expense: expenses[index]),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
          ),
    );
  }
}
