import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime myDate;

  Transaction({
    required this.id,
    required this.name,
    required this.myDate,
    required this.amount,
  });
}
