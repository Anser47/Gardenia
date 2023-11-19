import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/product_model.dart';

import 'package:gardenia/view/home/product_tile.dart';

class HomeScreenGrid extends StatelessWidget {
  HomeScreenGrid({
    Key? key,
    required this.productCollection,
  }) : super(key: key);

  final CollectionReference<Object?> productCollection;

  Future<List<ProductClass>> fetchProducts() async {
    List<ProductClass> productList = [];

    try {
      var productCollectionSnapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      if (productCollectionSnapshot.docChanges.isNotEmpty) {
        productList = productCollectionSnapshot.docs.map(
          (doc) {
            Map<String, dynamic> data = doc.data();
            return ProductClass.fromJson(data);
          },
        ).toList();
      } else {
        print("Error: Product collection snapshot is null");
      }
    } catch (e) {
      print("Error fetching products=======: $e");
    }

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProducts(),
      builder: (context, AsyncSnapshot<List<ProductClass>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Products'),
          );
        } else {
          List<ProductClass> productList = snapshot.data!;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.0 / 4.0,
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductTile(
                id: productList[index].id.toString(),
                name: productList[index].name ?? 'Empty',
                subname: productList[index].category ?? 'Empty',
                rate: productList[index].price ?? 'Empty',
                image: productList[index].imageUrl ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9k33VDGg4WcrLISmAosSXtH9LnRke9pcaBQ&usqp=CAU",
                description: productList[index].description ?? "empty",
              );
            },
          );
        }
      },
    );
  }
}
