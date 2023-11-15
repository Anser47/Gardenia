import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/cart_model.dart';
import 'package:gardenia/provider/cart/cart_provider.dart';
import 'package:gardenia/provider/wishlist/wishlist_provider.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});
  final CollectionReference wishlistCollection =
      FirebaseFirestore.instance.collection('wishlist');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: gcolor,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return StreamBuilder(
                stream: wishlistCollection.snapshots(),
                builder: (context, snapshot) {
                  List<QueryDocumentSnapshot<Object?>> data = [];
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('Add Products'),
                    );
                  }

                  data = snapshot.data!.docs;
                  if (snapshot.data!.docs.isEmpty || data.isEmpty) {
                    return const Center(
                      child: Text('No Products'),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
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
                                  data[index]['imageUrl'] ?? 'shi' ?? '',
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
                                      data[index]['name'] ?? 'name',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '₹ ${data[index]['price'] ?? '84'}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            'Category: ${data[index]['category'] ?? '84'} '),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.shopping_cart_outlined),
                                    onPressed: () {
                                      final addToCart = CartModel(
                                        name: data[index]['name'],
                                        price: data[index]['price'],
                                        category: data[index]['category'],
                                        description: data[index]['description'],
                                        imageUrl: data[index]['imageUrl'],
                                        id: data[index]['id'],
                                        quantity: '1',
                                      );
                                      context.read<CartProvider>().addToCart(
                                            context: context,
                                            value: addToCart,
                                          );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () async {
                                      final String id = data[index]['id'];
                                      await context
                                          .read<WishlistProvider>()
                                          .deleteWishlist(
                                              id: id, context: context);
                                      debugPrint(
                                          '=========================== ${data[index]['id']}');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.constraints,
    required this.name,
    required this.price,
  });
  final String name;
  final String price;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.8JpeNaTXEvw3UCcRe0IbOQHaIz%26pid%3DApi&f=1&ipt=26bb7939adac561ef3f061851faaef6da51a1e39a93709226c0334946a7cf612&ipo=images', // Replace with your product image URL
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹99.99',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
