import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/product_model.dart';
import 'package:gardenia/model/wishlist_model.dart';
import 'package:gardenia/provider/wishlist/wishlist_provider.dart';
import 'package:gardenia/shared/product_discription.dart';
import 'package:gardenia/view/home/product_tile.dart';
import 'package:provider/provider.dart';

// class HomeScreenGrid extends StatefulWidget {
//   const HomeScreenGrid({
//     super.key,
//     required this.productCollection,
//   });

//   final CollectionReference<Object?> productCollection;

//   @override
//   State<HomeScreenGrid> createState() => _HomeScreenGridState();
// }

// class _HomeScreenGridState extends State<HomeScreenGrid> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
//         const aspectRatio = 3.0 / 4.0;
//         return StreamBuilder(
//           stream: widget.productCollection.snapshots(),
//           builder: (context, snapshot) {
//             List<QueryDocumentSnapshot<Object?>> data = [];
//             if (snapshot.data == null) {
//               return const Center(
//                 child: Text('Add Products'),
//               );
//             }
//             data = snapshot.data!.docs;
//             if (snapshot.data!.docs.isEmpty || data.isEmpty) {
//               return const Center(
//                 child: Text('No Products'),
//               );
//             }
//             print(
//               '--------------------${data.length}',
//             );
//             return GridView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 childAspectRatio: aspectRatio,
//                 crossAxisCount: crossAxisCount,
//                 crossAxisSpacing: 1.0,
//                 mainAxisSpacing: 1.0,
//               ),
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasData) {
//                   return ProductTile(
//                       id: data[index]['id'],
//                       name: data[index]['name'] ?? 'Empty',
//                       subname: data[index]['category'] ?? 'Empty',
//                       rate: data[index]['price'] ?? 'Empty',
//                       image: data[index]['imageUrl'] ??
//                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9k33VDGg4WcrLISmAosSXtH9LnRke9pcaBQ&usqp=CAU",
//                       description: data[index]['description'] ?? "empty");
//                 }
//                 return const Text('empty');
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

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
