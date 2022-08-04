import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTrans;

  NewTransactions(this.addTrans);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = int.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTrans(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(52),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => submitData(),
              decoration:
                  InputDecoration(labelText: 'Введи наименование покупки'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(labelText: 'Введи потраченную сумму'),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: submitData,
                child: Text('Добавить трату'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
