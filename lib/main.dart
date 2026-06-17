// Lab assignment 4 - Mortgage Calculator
// Group: Colin Schulte, Dylan Schulte
// main.dart

import 'package:flutter/material.dart';
import 'package:lab_assignment_4/mortgage.dart';
import 'package:lab_assignment_4/mortgage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mortgage Calculator',
      home: MortgageScreen(mortgage: Mortgage()),
    );
  }
}
