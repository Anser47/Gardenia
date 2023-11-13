import 'package:flutter/material.dart';
import 'package:gardenia/view/address/address_screen.dart';
import 'package:gardenia/view/profile/editing_screens.dart/editing_screen.dart';

class AddEditAddressButtons extends StatelessWidget {
  AddEditAddressButtons({
    required this.id,
    super.key,
  });
  String id;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9.0, bottom: 20, right: 9),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return EditingScreen(
                    id: id,
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScreenAddNewAddress(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
    );
  }
}
