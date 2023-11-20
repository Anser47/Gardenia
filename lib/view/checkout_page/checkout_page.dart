import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/provider/address/address_provider.dart';
import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/checkout_page/card_checkout.dart';
import 'package:gardenia/view/checkout_page/heading_delivery.dart';
import 'package:gardenia/view/profile/address/dafault_card.dart';
import 'package:gardenia/view/profile/address_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Razorpay razorpay = Razorpay();

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.name,
    required this.price,
    required this.discription,
    required this.image,
  });
  final String name;
  final String price;
  final String discription;
  final String image;

  @override
  Widget build(BuildContext context) {
    // final alertDialogProvider = Provider.of<AlertDialogProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final razorpayProvider = Provider.of<RazorpayProvider>(context);

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<CheckoutProvider>(
            builder: (context, value, widget) {
              int totalPrice = value.calulateTotal(price);
              return Column(
                children: [
                  kHeight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: size.height / 8,
                      child: DeliveryHeading(size: size),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 9,
                      right: 9,
                    ),
                    child: DefaultAddress(size: size),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenAddress(),
                        ),
                      );
                      context
                          .read<AddressProvider>()
                          .showSnackbar(context, 'Change address default');
                    },
                    child: const Text('Change Address'),
                  ),
                  kHeight20,
                  CheckoutCard(
                      image: image,
                      name: name,
                      price: price,
                      checkoutProvider: checkoutProvider,
                      totalPrice: totalPrice),
                  kHeight20,
                  ListTile(
                    leading: Radio<PaymentCategory>(
                      groupValue: checkoutProvider.paymentCategory,
                      value: PaymentCategory.paynow,
                      onChanged: (PaymentCategory? value) {
                        checkoutProvider.setPaymentCategory(value!);
                      },
                    ),
                    title: const Text('Pay Now'),
                  ),
                  ListTile(
                    leading: Radio<PaymentCategory>(
                      groupValue: checkoutProvider.paymentCategory,
                      value: PaymentCategory.cashondelivery,
                      onChanged: (PaymentCategory? value) {
                        checkoutProvider.setPaymentCategory(value!);
                      },
                    ),
                    title: const Text('Cash on delivery'),
                  ),
                  kHeight50,
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 12,
                    child: CommonButton(
                      name: "Confirm order",
                      voidCallback: () {
                        if (checkoutProvider.paymentCategory ==
                            PaymentCategory.paynow) {
                          final user = FirebaseAuth.instance.currentUser;
                          var options = {
                            'key': 'rzp_test_EunImdr5xuJGFC',
                            'amount': totalPrice * 100,
                            'name': 'Gardenia',
                            'description': name,
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '8078711479',
                              'email': user!.email
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          razorpayProvider.openRazorpayPayment(
                            options: options,
                            onError: (response) {
                              handlePaymentErrorResponse(response, context);
                            },
                            onSuccess: (response) {
                              handlePaymentSuccessResponse(response, context);
                            },
                          );
                        } else {
                          value.showPaymentCompletedDialog(context);
                          // if (!alertDialogProvider.showDialog) {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return const ScreenNavWidget();
                          //     },
                          //   );
                          // }
                        }
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(
        context, "Payment Failed", "\nDescription: ${response.message}}");
  }

  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response, BuildContext context) {
    String id = response.orderId.toString();

    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
