import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/order_model.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/profile/screens/orders/order_detiles.dart';
import 'package:shimmer/shimmer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Order').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Shimmer loading state
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView(
                children: List.generate(
                  10,
                  (index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      color: Colors.grey[300],
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<OrderModel> orders = snapshot.data!.docs
                .map((doc) =>
                    OrderModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                OrderModel order = orders[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            order: order,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: gcolor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: Container(
                            width: 70.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(order.imageUrl ?? ''),
                              ),
                            ),
                          ),
                          title: Text(
                            order.productName ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              Text('Date: ${order.date ?? ''}'),
                              Text('Status: ${order.status ?? ''}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
