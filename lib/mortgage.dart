// Lab assignment 4 - Mortgage Calculator
// Group: Colin Schulte, Dylan Schulte
// mortgage.dart

import 'dart:math';

class Mortgage {
  double amount;
  int years;
  double rate;

  Mortgage({this.amount = 100000, this.years = 30, this.rate = 0.035});

  void setAmount(double newAmount) {
    if (newAmount >= 0) {
      amount = newAmount;
    }
  }

  void setYears(int newYears) {
    if (newYears >= 0) {
      years = newYears;
    }
  }

  void setRate(double newRate) {
    if (newRate >= 0) {
      rate = newRate;
    }
  }

  double monthlyPayment() {
    double mRate = rate / 12;

    double temp = pow(1 / (1 + mRate), years * 12).toDouble();

    return amount * mRate / (1 - temp);
  }

  double totalPayment() {
    return monthlyPayment() * years * 12;
  }

  String formattedAmount() {
    return "\$${amount.toStringAsFixed(2)}";
  }

  String formattedMonthlyPayment() {
    return "\$${monthlyPayment().toStringAsFixed(2)}";
  }

  String formattedTotalPayment() {
    return "\$${totalPayment().toStringAsFixed(2)}";
  }
}
