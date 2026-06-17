// Lab assignment 5 - Mortgage Calculator
// Group: Colin Schulte, Dylan Schulte
// mortgage_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lab_assignment_4/mortgage_provider.dart';
import 'modify_screen.dart';

class MortgageScreen extends StatefulWidget {
  const MortgageScreen({super.key});

  @override
  State<MortgageScreen> createState() => _MortgageScreenState();
}

class _MortgageScreenState extends State<MortgageScreen> {
  bool _acceptedTerms = false;

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Terms & Conditions"),
          content: const Text("Do you accept the terms and conditions?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _acceptedTerms = false;
                });
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _acceptedTerms = true;
                });
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mortgage = Provider.of<MortgageProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Mortgage Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amount: \$${mortgage.amount.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            Text(
              "Years: ${mortgage.years}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            Text(
              "Interest Rate: ${(mortgage.rate * 100).toStringAsFixed(2)}%",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            Text(
              "Monthly Payment: \$${mortgage.monthlyPayment().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            Text(
              "Total Payment: \$${mortgage.totalPayment().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    _showTermsDialog();
                  },
                ),
                const Text("Terms & Conditions"),
              ],
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ModifyScreen()),
                  );
                },
                child: const Text("Modify Data"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
