import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/cart_model.dart';

import 'package:gardenia/provider/cart/cart_provider.dart';
import 'package:gardenia/sample.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:provider/provider.dart';

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
                  return Center(
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

                              return CartProductCard(
                                name: data[index]['name'] ?? 'name',
                                price: data[index]['price'] ?? '84',
                                constraints: constraints,
                                image: data[index]['imageUrl'] ??
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShiq-YDkgihdO9XD29qY3p58tiBINmzqZD8Q&usqp=CAU',
                                quantity: data[index]['quantity'] ?? 'quantity',
                                discription:
                                    data[index]['description'] ?? 'discription',
                                id: data[index]['id'] ?? '23',
                              );
                            },
                          );
                          //   },
                          // );
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CheckoutScree(
                                            total: total,
                                          )));
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

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.constraints,
    required this.image,
    required this.quantity,
    required this.discription,
    required this.id,
  });
  final String name;
  final String image;
  final String quantity;
  final String discription;
  final String price;
  final String id;
  final BoxConstraints constraints;

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
                      const Text('quantity: '),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          context.read<CartProvider>().reduceK(id, quantity);
                        },
                      ),
                      Text(quantity),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          context.read<CartProvider>().addK(id, quantity);
                          // context.read<CartProvider>().fetchCart();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                context
                    .read<CartProvider>()
                    .deleteCart(id: id, context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
