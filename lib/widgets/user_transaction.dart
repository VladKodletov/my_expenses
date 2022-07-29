import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}


class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      name: 'Новые ботинки',
      amount: 650,
      myDate: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      name: 'Новая рубашка',
      amount: 400,
      myDate: DateTime.now(),
    ),
  ];

  void _addTransaction(String tittle, double amountAdd) {
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      name: tittle,
      myDate: DateTime.now(),
      amount: amountAdd,
    );
    setState(() {
      _userTransactions.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransactions(_addTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
