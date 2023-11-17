import 'package:flutter/material.dart';
import 'package:gardenia/model/address_model.dart';
import 'package:gardenia/provider/address/address_provider.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/profile/address/address_card.dart';
import 'package:gardenia/view/checkout_page/heading_delivery.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: gcolor),
          child: SingleChildScrollView(
            child: Column(
              children: [
                kHeight20,
                DeliveryHeading(size: size),
                kHeight20,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<AddressModel>>(
                    future: context.read<AdressProvider>().fetchAddress(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No addresses available.'),
                        );
                      } else {
                        final address = snapshot.data!;
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: address.length,
                            itemBuilder: (context, index) {
                              return AddressCard(
                                size: size,
                                area: address[index].area ?? 'address',
                                city: address[index].city ?? 'city',
                                fullname: address[index].fullname ?? 'fullname',
                                house: address[index].house ?? 'house',
                                id: address[index].id ?? "id",
                                phone: address[index].phone ?? "phone",
                                pincode: address[index].pincode ?? "pincode",
                                state: address[index].state ?? "state",
                              );
                            });
                      }
                    },
                  ),
                ),
                kHeight50,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
