import 'package:flutter/material.dart';
import 'package:gardenia/shared/bottomnavigation/core/constants.dart';

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
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return CartProductCard(
                          name: 'sdf',
                          price: 324,
                          constraints: constraints,
                        );
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
  });
  final String name;
  final double price;
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
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.6IeEzE8WjRisNJks_ytv-AHaJO%26pid%3DApi&f=1&ipt=41acb58a3b29bc0977c9f208e79bd3319dd0788e2b8f14f1917f68b5d6fbfed4&ipo=images',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '₹99.99',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('quantity'),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const Text('3'),
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
