import 'package:flutter/material.dart';
import 'package:gardenia/view/profile/address/add_edit_buttons.dart';

class DefaultAddress extends StatelessWidget {
  DefaultAddress(
      {required this.size,
      required this.id,
      required this.fullname,
      required this.pincode,
      required this.city,
      required this.state,
      required this.phone,
      required this.house,
      required this.area,
      super.key});
  String id;
  String fullname;
  String pincode;
  String city;
  String state;
  String phone;
  String house;
  String area;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 6,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color.fromARGB(255, 216, 215, 215),
            ),
            height: size.height / 3.2,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 90, top: 9),
                  child: Text(
                    'Name: ${fullname}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
                  child: Text(
                    'Address: ${house}, ${area}, ${city}, ${state}, ${pincode}, ',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
                  child: Text(
                    'Phone Number: ${phone}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 4,
                  ),
                ),
                AddEditAddressButtons(
                  id: id,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
