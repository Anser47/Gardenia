import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum PaymentCategory { cashondelivery, paynow }

class CheckoutProvider extends ChangeNotifier {
  int _totalNum = 1;
  set totalNum(int value) {
    _totalNum = value;
  }

  int get totalNum => _totalNum;
  void addNum() {
    _totalNum++;
    notifyListeners();
  }

  void reduceNum() {
    _totalNum--;
    notifyListeners();
  }

  int calulateTotal(String value) {
    int price = int.tryParse(value) ?? 0;
    if (_totalNum != 0 || _totalNum <= 0) {
      int lastprice = price * _totalNum;
      return lastprice;
    } else {
      debugPrint('== ======== =calculating price have error==========');
      return 0;
    }
  }

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

class RazorpayProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  late Function(PaymentFailureResponse) _onPaymentFailure;
  late Function(PaymentSuccessResponse) _onPaymentSuccess;

  RazorpayProvider() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  void openRazorpayPayment({
    required Map<String, dynamic> options,
    required Function(PaymentFailureResponse) onError,
    required Function(PaymentSuccessResponse) onSuccess,
  }) {
    _razorpay.open(options);
    _onPaymentFailure = onError;
    _onPaymentSuccess = onSuccess;
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    _onPaymentFailure(response);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _onPaymentSuccess(response);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
