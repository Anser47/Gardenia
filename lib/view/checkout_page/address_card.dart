import 'package:flutter/material.dart';
import 'package:gardenia/model/address_model.dart';
import 'package:gardenia/provider/address/address_provider.dart';
import 'package:gardenia/view/checkout_page/add_edit_buttons.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    required this.size,
  }) : super(key: key);

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
            height: size.height / 5,
            width: double.infinity,
            child: FutureBuilder<List<AddressModel>>(
              future: context.read<AdressProvider>().fetchAddress(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No addresses available.'),
                  );
                } else {
                  final address = snapshot.data![0];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 90, top: 9),
                        child: Text(
                          'Name: ${address.fullname}',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 85, top: 4),
                        child: Text(
                          'Address: ${address.house}, ${address.area}, ${address.city}, ${address.state}, ${address.pincode}, ',
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 85, top: 4),
                        child: Text(
                          'Phone Number: ${address.phone}',
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        AddEditAddressButtons(
          id: '',
        )
      ],
    );
  }
}
