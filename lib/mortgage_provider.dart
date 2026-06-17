import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MortgageProvider extends ChangeNotifier {
  double amount = 100000;
  int years = 30;
  double rate = 0.035;

  MortgageProvider() {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    amount = prefs.getDouble('amount') ?? 100000;
    years = prefs.getInt('years') ?? 30;
    rate = prefs.getDouble('rate') ?? 0.035;

    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('amount', amount);
    await prefs.setInt('years', years);
    await prefs.setDouble('rate', rate);
  }

  Future<void> setAmount(double value) async {
    amount = value;
    await saveData();
    notifyListeners();
  }

  Future<void> setYears(int value) async {
    years = value;
    await saveData();
    notifyListeners();
  }

  Future<void> setRate(double value) async {
    rate = value;
    await saveData();
    notifyListeners();
  }

  double monthlyPayment() {
    double mRate = rate / 12;

    double temp = pow(1 / (1 + mRate), years * 12).toDouble();

    return amount * mRate / (1 - temp);
  }

  double totalPayment() {
    return monthlyPayment() * years * 12;
  }
}
