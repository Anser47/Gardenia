import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          // Expanded ListView to display cart items
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the number of cart items
              itemBuilder: (context, index) {
                // Replace this with your CartItem widget
                return CartItem(
                  productName: 'Product $index',
                  price: 10.0,
                  quantity: 2,
                );
              },
            ),
          ),
          // Cart summary at the bottom
          CartSummaryWidget(),
        ],
      ),
    );
  }
}

class CartSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace these values with your actual cart data
    int totalItems = 15;
    double totalAmount = 150.0;

    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue, // Customize the background color as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Items: $totalItems',
              style: TextStyle(color: Colors.white)),
          Text('Total Amount: ₹$totalAmount',
              style: TextStyle(color: Colors.white)),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Implement your place order logic here
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String productName;
  final double price;
  final int quantity;

  CartItem({
    required this.productName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(productName),
      subtitle: Text('Price: ₹$price | Quantity: $quantity'),
    );
  }
}
