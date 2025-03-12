import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddNewExpense, super.key});

  final Function(Expense expense) onAddNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpanseState();
  }
}

class _NewExpanseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;
  bool errorFlag = false;

  void _closeAddNewExpenseModelBottomSheet() {
    Navigator.pop(context);
  }

  void _saveExpense() {
    final enteredAmount = (double.tryParse(_amountController.text));
    final isAmountInvalid = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        _selectedDate == null) {
      setState(() {
        errorFlag = true;
      });
      showDialog(
        barrierColor: const Color.fromARGB(15, 223, 64, 251),
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text("Invalid input"),
              content: Text(
                "Please make sure to valid the Title, Amount, Date was entered",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Close"),
                ),
              ],
            ),
      );
      return;
    }
    widget.onAddNewExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    _closeAddNewExpenseModelBottomSheet();
  }

  void setChosedCategory(Category? chosedCategory) {
    if (chosedCategory != null) {
      setState(() {
        _selectedCategory = chosedCategory;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final nowDate = DateTime.now();
    final initDate = DateTime(nowDate.year - 1, nowDate.month, nowDate.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: initDate,
      lastDate: nowDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            onChanged: (value) {
              setState(() {});
            },
            maxLength: 50,
            decoration: InputDecoration(
              label: Text("Title"),
              errorText:
                  (errorFlag && _titleController.text.isEmpty)
                      ? "Please add a Title"
                      : null,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text("Please add an Amount"),
                    errorText:
                        (errorFlag && _amountController.text.isEmpty)
                            ? "Please add an Amount"
                            : null,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ${_date.day}/${_date.month}/${_date.year}
                    Text(
                      _selectedDate == null
                          ? "Select a Date"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                hint: Text("Category"),
                onChanged: setChosedCategory,
              ),
              Spacer(),
              TextButton(
                onPressed: _closeAddNewExpenseModelBottomSheet,
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _saveExpense,
                child: Row(
                  children: [
                    Text("Save Expense"),
                    SizedBox(width: 4),
                    Icon(Icons.savings_rounded),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
