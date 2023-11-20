import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final List<Order> ordersList = [
    Order(
        id: '1',
        status: 'Completed',
        productName: 'Product A',
        quantity: 2,
        totalPrice: 50.0),
    Order(
        id: '4',
        status: 'PENDING',
        productName: 'NAME',
        quantity: 4,
        totalPrice: 46)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ordersList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'No Orders',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Column(
                  children: ordersList
                      .map((order) => _buildOrderCard(order))
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          order.productName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(
              'Quantity: ${order.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Price: ₹ ${order.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: Text(
          order.status,
          style: TextStyle(
            fontSize: 18,
            color: order.status == 'Completed' ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          width: 60.0, // Adjust the width as needed
          height: 60.0, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.grey[300], // Placeholder color
            borderRadius: BorderRadius.circular(8.0),
          ),
          // Add your image widget here
          // child: YourImageWidget(),
        ),
        onTap: () {
          // Handle tapping on an order (if needed)
        },
      ),
    );
  }
}

class Order {
  final String id;
  final String status;
  final String productName;
  final int quantity;
  final double totalPrice;

  Order({
    required this.id,
    required this.status,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });
}
