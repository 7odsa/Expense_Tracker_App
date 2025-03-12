import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 8, 238, 0),
);
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        dropdownMenuTheme: DropdownMenuThemeData().copyWith(
          textStyle: TextStyle(color: kColorScheme.primaryContainer),
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        iconTheme: const IconThemeData().copyWith(
          // color:
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          ),
        ),
        textTheme: TextTheme().copyWith(),
      ),
      home: Expenses(),
    ),
  );
}
