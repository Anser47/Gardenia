import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/cart/cart_product_card.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('Cart');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Cart',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: gcolor,
          ),
          child: StreamBuilder(
              stream: cartCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<QueryDocumentSnapshot<Object?>> data =
                    snapshot.data?.docs ?? [];
                String total = calculateTotalPrice(data);
                return Column(
                  children: [
                    kHeight20,
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text('No Products'),
                            );
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return CartCard(
                                  name: data[index]['name'] ?? 'name',
                                  price: data[index]['price'] ?? '84',
                                  image: data[index]['imageUrl'] ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShiq-YDkgihdO9XD29qY3p58tiBINmzqZD8Q&usqp=CAU',
                                  quantity:
                                      data[index]['quantity'] ?? 'quantit',
                                  description:
                                      data[index]['description'] ?? 'quantity',
                                  id: data[index]['id'] ?? 'null');
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 70,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              subtitle: Text(
                                'Total (${snapshot.data!.docs.length} items):',
                              ),
                              title: Text(
                                '₹ $total',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => CheckoutScree(
                                  //           total: total,
                                  //         )));
                                  // CheckoutScree(products: products);
                                  // debugPrint('==  ======  =====${data.length}');
                                  // debugPrint('========$total = = == =');
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    elevation: 8,
                                    shadowColor: Colors.grey,
                                    backgroundColor: Colors.green),
                                child: const Text('Place Order'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  String calculateTotalPrice(List<QueryDocumentSnapshot<Object?>> data) {
    double total = 0;

    for (var item in data) {
      try {
        double price = double.tryParse(item['price'].toString()) ?? 0;
        int quantity = int.tryParse(item['quantity'].toString()) ?? 0;
        total += price * quantity;
        print(
            '=============   Price: $price, Quantity: $quantity, Total: $total');
      } catch (e) {
        print('Error calculating total price: $e');
      }
    }

    return total.toStringAsFixed(2);
  }
}

final e = Container(
  height: 200,
  width: 300,
  color: Colors.amber,
);
