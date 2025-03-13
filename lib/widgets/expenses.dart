import 'package:expense_tracker_app/widgets/chart/chart.dart';
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

  bool get isPortriatMode =>
      MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

  Widget getBodyWidgetBasedOnTheOriantationMode() {
    return isPortriatMode
        ? Column(
          children: [
            Chart(expenses: _expensesList),

            SizedBox(height: 16),
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
        )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: Chart(expenses: _expensesList)),

            SizedBox(width: 8),
            Expanded(
              flex: 5,
              child:
                  (_expensesList.isEmpty)
                      ? _showNodata()
                      : ExpansesList(
                        onRemoveExpense: _removeExpense,
                        expenses: _expensesList,
                      ),
            ),
          ],
        );
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getBodyWidgetBasedOnTheOriantationMode(),
      ),
    );
  }
}
