import 'package:flutter/material.dart';
import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/address/address_screen.dart';
import 'package:gardenia/view/checkout_page/address_card.dart';
import 'package:gardenia/view/checkout_page/checkout_product_card.dart';
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
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(
                          width: size.width / 8,
                        ),
                        const Text(
                          'Delivery Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 9,
                    right: 9,
                  ),
                  child: AddressCard(size: size),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 9.0, bottom: 20, right: 9),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            Text(
                              '  Edit Address',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 9.0, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ScreenAddNewAddress()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              ' Add Address',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                CommonButton(
                  name: "Confirm order",
                  voidCallback: () {
                    if (checkoutProvider.paymentCategory ==
                        PaymentCategory.paynow) {
                      var options = {
                        'key': 'rzp_live_ILgsfZCZoFIKMb',
                        'amount': 100,
                        'name': 'Acme Corp.',
                        'description': 'Fine T-Shirt',
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com'
                        },
                        'external': {
                          'wallets': ['paytm']
                        }
                      };
                      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                          handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          handlePaymentSuccessResponse);
                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          handleExternalWalletSelected);
                      razorpay.open(options);
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
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
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
      onPressed: () {},
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
