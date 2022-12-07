import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_expenses/features/mainscreen/data/models/transaction.dart';
import 'package:my_expenses/features/mainscreen/presentation/mainscreen.dart';

late Box box;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  box = await Hive.openBox<Transaction>('transactions');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Твои расходы',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.orange,
                backgroundColor: Colors.orange[400])
            .copyWith(secondary: Colors.grey[200]),
      ),
      home: const MyHomePage(),
    );
  }
}
