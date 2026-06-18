// Lab assignment 5 - Mortgage Calculator
// Group: Colin Schulte, Dylan Schulte
// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lab_assignment_4/mortgage_provider.dart';
import 'package:lab_assignment_4/mortgage_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MortgageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mortgage Calculator',
      home: MortgageScreen(),
    );
  }
}
