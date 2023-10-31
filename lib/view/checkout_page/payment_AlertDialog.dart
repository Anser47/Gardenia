import 'package:flutter/material.dart';
import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/view/home/home_screen.dart';
import 'package:provider/provider.dart';

class PaymentSuccessAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alertDialogProvider = Provider.of<AlertDialogProvider>(context);
    return AlertDialog(
      title: Text('Payment Successful'),
      content: Text('Your payment has been successfully processed.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            alertDialogProvider.hideAlertDialog();
            // Navigate to another page here
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(); // Replace with the destination page
                },
              ),
            );
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
