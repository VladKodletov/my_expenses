import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_expenses/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class MainChart extends StatelessWidget {
  const MainChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, child) => Chart(),
      valueListenable: Hive.box<Transaction>('transactions').listenable(),
    );
  }
}

class Chart extends StatelessWidget {
  Chart({super.key});

  final List<Transaction> userTransactions =
      Hive.box<Transaction>('transactions').values.toList().cast<Transaction>();

  List<Transaction> get recentTransactions {
    return userTransactions.where((tx) {
      return tx.myDate.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].myDate.day == weekDay.day &&
            recentTransactions[i].myDate.month == weekDay.month &&
            recentTransactions[i].myDate.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (data['day'] as String),
                (data['amount'] as double),
                totalSpending == 0
                    ? 0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
