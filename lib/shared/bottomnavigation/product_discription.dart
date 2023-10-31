import 'package:flutter/material.dart';
import 'package:gardenia/view/checkout_page/checkout_page.dart';

class ProductDiscription extends StatelessWidget {
  const ProductDiscription(
      {super.key,
      required this.name,
      required this.price,
      required this.category,
      required this.discription,
      required this.img});
  final String name;
  final String price;
  final String category;
  final String discription;
  final String img;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 1, 52, 3),
          title: const Text(
            'Product discription',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Discription(
            img: img,
            name: name,
            price: price,
            category: category,
            discription: discription),
      ),
    );
  }
}

class Discription extends StatelessWidget {
  const Discription({
    super.key,
    required this.img,
    required this.name,
    required this.price,
    required this.category,
    required this.discription,
  });

  final String img;
  final String name;
  final String price;
  final String category;
  final String discription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: 400,
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Row(
                  children: [
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Category: $category',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 133, 133, 133),
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Text(discription),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CheckoutSreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Buy',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
