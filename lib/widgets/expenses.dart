import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:expense_tracker_app/widgets/expanses_list/expanses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [];

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: "Undo",
          onPressed:
              () => setState(() => _expensesList.insert(expenseIndex, expense)),
        ),
        content: Text("Expense deleted."),
      ),
    );
  }

  Widget _showNodata() {
    return Center(child: Text("NoDataFound"));
  }

  void _openAddNewExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddNewExpense: addNewExpense),
    );
  }

  addNewExpense(expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("\$ Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddNewExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text("the chart", textAlign: TextAlign.center),
          Expanded(
            child:
                (_expensesList.isEmpty)
                    ? _showNodata()
                    : ExpansesList(
                      onRemoveExpense: _removeExpense,
                      expenses: _expensesList,
                    ),
          ),
        ],
      ),
    );
  }
}
