import 'package:flutter/material.dart';
import 'package:gardenia/provider/address/address_provider.dart';
import 'package:gardenia/view/profile/editing_screens.dart/editing_screen.dart';
import 'package:provider/provider.dart';

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
          padding:
              const EdgeInsets.only(top: 9.0, bottom: 20, right: 5, left: 10),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
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
          padding: const EdgeInsets.only(top: 9.0, bottom: 20, right: 1),
          child: ElevatedButton(
            onPressed: () async {
              context.read<AddressProvider>().deleteAddress(id);
              debugPrint('$id================== =');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  ' Remove Address',
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
