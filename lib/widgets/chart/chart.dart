import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense_bucket';
import 'package:expense_tracker_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (var bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(16),
          topEnd: Radius.circular(16),
          bottomStart: Radius.circular(8),
          bottomEnd: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  buckets
                      .map(
                        (bucket) => ChartBar(
                          fill:
                              maxTotalExpense == 0
                                  ? 0
                                  : (bucket.totalExpenses / maxTotalExpense),
                        ),
                      )
                      .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                buckets
                    .map(
                      (bucket) => Container(
                        margin: const EdgeInsets.all(4),
                        child: Icon(
                          categoryIcons[bucket.category],
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
