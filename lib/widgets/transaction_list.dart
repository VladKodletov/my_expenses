import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Hive.box<Transaction>('transactions').listenable(),
        builder: (context, Box<Transaction> box, _) {
          return box.values.isNotEmpty
              ? ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Transaction? myTransaction = box.getAt(index);
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange[900],
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: FittedBox(
                              child: Text('\$${myTransaction?.amount}'),
                            ),
                          ),
                        ),
                        title: Text(
                          myTransaction!.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMMd().format(myTransaction.myDate),
                        ),
                        trailing: MediaQuery.of(context).size.width > 500
                            ? IconButton(
                                icon: const Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () => myTransaction.delete(),
                                tooltip: 'Удалить',
                              )
                            : IconButton(
                                icon: const Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () => myTransaction.delete(),
                              ),
                      ),
                    );
                  })
              : LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: <Widget>[
                      const Text(
                        'Нет добавленных трат!',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                });
        });
  }
}
