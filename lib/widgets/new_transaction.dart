import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTrans;

  NewTransactions(this.addTrans);

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
              decoration:
                  InputDecoration(labelText: 'Введи наименование покупки'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Введи потраченную сумму'),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  addTrans(
                    titleController.text,
                    int.tryParse(amountController.value.text) ?? 0,
                  );
                },
                child: Text('Добавить трату'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
