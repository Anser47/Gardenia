import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/address/address_screen.dart';
import 'package:gardenia/view/checkout_page/add_edit_buttons.dart';
import 'package:gardenia/view/checkout_page/address_card.dart';
import 'package:gardenia/view/checkout_page/checkout_product_card.dart';
import 'package:gardenia/view/checkout_page/heading_delivery.dart';
import 'package:gardenia/view/checkout_page/payment_AlertDialog.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Razorpay razorpay = Razorpay();

class CheckoutSreen extends StatelessWidget {
  const CheckoutSreen({
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
  // final String quatity;
  @override
  Widget build(BuildContext context) {
    final alertDialogProvider = Provider.of<AlertDialogProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final razorpayProvider = Provider.of<RazorpayProvider>(context);

    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AlertDialogProvider(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                kHeight30,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height / 12,
                    child: DeliveryHeading(size: size),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 9,
                    right: 9,
                  ),
                  child: AddressCard(size: size),
                ),
                const AddEditAddressButtons(),
                kHeight20,
                CheckOutProuductCard(
                  discription: discription,
                  image: image,
                  name: name,
                  price: price,
                ),
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
                          'amount': int.parse(price) * 100,
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
                        if (!alertDialogProvider.showDialog) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PaymentSuccessAlertDialog();
                            },
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
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
