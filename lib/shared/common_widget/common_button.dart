import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  CommonButton({super.key, required this.name, required this.voidCallback});
  final String name;
  VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        voidCallback();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        minimumSize: MaterialStateProperty.all<Size>(const Size(350, 60)),
      ),
      child: const Text(
        'Log out',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
