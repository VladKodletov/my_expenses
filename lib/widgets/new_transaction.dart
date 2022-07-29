import 'package:flutter/material.dart';

class NewTransactions extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  Function addTrans;

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
              decoration:
                  InputDecoration(labelText: 'Введи наименование покупки'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Введи потраченную сумму'),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  addTrans(
                    titleController.text,
                    double.parse(amountController.text),
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
