import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:gardenia/provider/checkout_provider/checkout_provider.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';
import 'package:gardenia/view/address/address_card.dart';
import 'package:gardenia/view/checkout_page/heading_delivery.dart';
import 'package:gardenia/view/checkout_page/payment_AlertDialog.dart';
import 'package:provider/provider.dart';

class CheckoutScree extends StatelessWidget {
  CheckoutScree({
    Key? key,
    required this.total,
  }) : super(key: key);
  final String total;
  @override
  Widget build(BuildContext context) {
    final alertDialogProvider = Provider.of<AlertDialogProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final size = MediaQuery.of(context).size;
    final CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: cartCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<QueryDocumentSnapshot<Object?>> data =
                    snapshot.data?.docs ?? [];

                return Column(
                  children: [
                    const SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: ,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: AddressCard(size: size),
                    ),
                    const SizedBox(height: 20),
                    // Displaying Cart Items

                    ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return CartProductCard(
                          description:
                              data[index]['description'] ?? 'discription',
                          name: data[index]['name'] ?? 'name',
                          price: data[index]['price'] ?? '84',
                          image: data[index]['imageUrl'] ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShiq-YDkgihdO9XD29qY3p58tiBINmzqZD8Q&usqp=CAU',
                          quantity: data[index]['quantity'] ?? 'quantity',
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Payment Options
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
                    const SizedBox(height: 50),
                    // Confirm Order Button
                    CommonButton(
                      name: "Confirm order",
                      voidCallback: () {
                        // Handle payment and order confirmation logic here
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.description,
  }) : super(key: key);

  final String name;
  final String price;
  final String image;
  final String quantity;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '₹ $price',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Quantity: '),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          // Handle decreasing quantity logic
                        },
                      ),
                      Text(quantity),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // Handle increasing quantity logic
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Description: $description',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
