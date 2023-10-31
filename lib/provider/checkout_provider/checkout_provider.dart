import 'package:flutter/material.dart';

enum PaymentCategory { cashondelivery, paynow }

class CheckoutProvider extends ChangeNotifier {
  PaymentCategory _paymentCategory = PaymentCategory.paynow;

  PaymentCategory get paymentCategory => _paymentCategory;

  void setPaymentCategory(PaymentCategory category) {
    _paymentCategory = category;
    notifyListeners();
  }
}

class BottomSheetProvider extends ChangeNotifier {
  bool _showBottomSheet = false;

  bool get bottomSheet => _showBottomSheet;

  void showBottomSheet() {
    _showBottomSheet = true;
    notifyListeners();
  }

  void hideBottomSheet() {
    _showBottomSheet = false;
    notifyListeners();
  }
}

class AlertDialogProvider with ChangeNotifier {
  bool _showDialog = false;

  bool get showDialog => _showDialog;

  void showAlertDialog() {
    _showDialog = true;
    notifyListeners();
  }

  void hideAlertDialog() {
    _showDialog = false;
    notifyListeners();
  }
}
