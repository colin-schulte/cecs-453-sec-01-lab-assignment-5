// Lab assignment 5 - Mortgage Calculator
// Group: Colin Schulte, Dylan Schulte
// modify_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lab_assignment_4/mortgage_provider.dart';

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  late TextEditingController _amountController;

  int _selectedYears = 30;
  double _selectedRate = 0.035;

  final List<double> rates = List.generate(
    53,
    (index) => (2.0 + (index * 0.25)) / 100,
  );

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mortgage = Provider.of<MortgageProvider>(context);

    if (_amountController.text.isEmpty) {
      _amountController.text = mortgage.amount.toString();
      _selectedYears = mortgage.years;
      _selectedRate = mortgage.rate;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Modify Mortgage")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Years
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Years", style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    Radio<int>(
                      value: 10,
                      groupValue: _selectedYears,
                      onChanged: (value) {
                        setState(() {
                          _selectedYears = value!;
                        });
                      },
                    ),
                    const Text("10"),

                    Radio<int>(
                      value: 15,
                      groupValue: _selectedYears,
                      onChanged: (value) {
                        setState(() {
                          _selectedYears = value!;
                        });
                      },
                    ),
                    const Text("15"),

                    Radio<int>(
                      value: 30,
                      groupValue: _selectedYears,
                      onChanged: (value) {
                        setState(() {
                          _selectedYears = value!;
                        });
                      },
                    ),
                    const Text("30"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Amount", style: TextStyle(fontSize: 18)),

                const SizedBox(width: 20),

                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Interest Rate", style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 10),

            Container(
              height: 200,
              decoration: BoxDecoration(border: Border.all()),
              child: ListView.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final rate = rates[index];

                  return ListTile(
                    selected: rate == _selectedRate,
                    title: Text("${(rate * 100).toStringAsFixed(2)}%"),
                    onTap: () {
                      setState(() {
                        _selectedRate = rate;
                      });
                    },
                  );
                },
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () async {
                final amount = double.tryParse(_amountController.text) ?? 0;

                await mortgage.setAmount(amount);
                await mortgage.setYears(_selectedYears);
                await mortgage.setRate(_selectedRate);

                if (!mounted) return;

                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
