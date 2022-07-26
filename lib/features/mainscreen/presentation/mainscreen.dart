import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_expenses/features/mainscreen/data/models/transaction.dart';
import 'package:my_expenses/main.dart';

import 'package:my_expenses/features/chart_bar/presentation/chart.dart';
import 'package:my_expenses/features/new_transaction/presentation/new_transaction.dart';
import 'package:my_expenses/features/mainscreen/presentation/widgets/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //обратить внимание на метод перевода инфы из box в List<Transaction>

  bool _showChart = false;

  addTransaction(
    String tittle,
    double amountAdd,
    DateTime chosenDate,
  ) {
    final newTrans = Transaction(
      name: tittle,
      amount: amountAdd,
      myDate: chosenDate,
      id: DateTime.now().toString(),
    );
    box.add(newTrans);
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return NewTransactions(addTransaction);
        });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    final isLandscape = mediaQ.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Мои расходы'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    final txListWidget = SizedBox(
        height: (mediaQ.size.height -
                appBar.preferredSize.height -
                mediaQ.padding.top) *
            0.7,
        child: const TransactionList());
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Показать диаграмму'),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              SizedBox(
                  height: (mediaQ.size.height -
                          appBar.preferredSize.height -
                          mediaQ.padding.top) *
                      0.3,
                  child: const MainChart()),
            // child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (mediaQ.size.height -
                              appBar.preferredSize.height -
                              mediaQ.padding.top) *
                          0.7,
                      child: const MainChart())
                  // child: Chart(_recentTransactions))
                  : txListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              backgroundColor: Colors.orange[700],
              child: const Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }
}
