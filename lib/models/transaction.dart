import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String name;
  final DateTime myDate;
  final double amount;

  Transaction({
    required this.id,
    required this.name,
    required this.myDate,
    required this.amount,
  });
}
