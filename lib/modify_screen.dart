// Lab assignment 4 - Mortgage Calculator
// Group: Colin Schulte, Dylan Schulte
// modify_screen.dart

import 'package:flutter/material.dart';
import 'package:lab_assignment_4/mortgage.dart';

class ModifyScreen extends StatefulWidget {
  final Mortgage mortgage;

  const ModifyScreen({super.key, required this.mortgage});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  late TextEditingController _amountController;

  int _selectedYears = 30;
  double _selectedRate = 3.5;

  final List<double> rates = List.generate(
    53,
    (index) => (2.0 + (index * 0.25)) / 100,
  );

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController(
      text: widget.mortgage.amount.toString(),
    );

    _selectedYears = widget.mortgage.years;
    _selectedRate = widget.mortgage.rate;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                widget.mortgage.setAmount(double.parse(_amountController.text));

                widget.mortgage.setYears(_selectedYears);

                widget.mortgage.setRate(_selectedRate);

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
