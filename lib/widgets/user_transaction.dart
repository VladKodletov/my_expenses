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
      myDate: DateTime.now(),
      amount: 650,
    ),
    Transaction(
      id: 't2',
      name: 'Новая рубашка',
      myDate: DateTime.now(),
      amount: 400,
    ),
  ];

  void _addTransaction(String tittle, int amountAdd) {
    final newTrans = Transaction(
      name: tittle,
      amount: amountAdd,
      myDate: DateTime.now(),
      id: DateTime.now().toString(),
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
