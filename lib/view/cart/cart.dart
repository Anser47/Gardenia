import 'package:flutter/material.dart';
import 'package:gardenia/model/cart_model.dart';
import 'package:gardenia/provider/cart/cart_provider.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return FutureBuilder<List<CartModel>>(
                      future: context.read<CartProvider>().fetchCart(),
                      builder: (contex, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('error ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('Add item to your cart'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final cart = snapshot.data;
                          return ListView.builder(
                            itemCount: cart!.length,
                            itemBuilder: (context, index) {
                              return CartProductCard(
                                name: cart[index].name!,
                                price: cart[index].price!,
                                constraints: constraints,
                                image: cart[index].imageUrl!,
                                quantity: cart[index].imageUrl!,
                                discription: cart[index].description!,
                                id: cart[index].id!,
                              );
                            },
                          );
                        }
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
                        subtitle: const Text('Total(8 items):'),
                        title: const Text(
                          '₹ 340',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {},
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
          ),
        ),
      ),
    );
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
                      const Text('quantity:'),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const Text('4'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
