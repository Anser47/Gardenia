import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/wishlist_model.dart';
import 'package:gardenia/provider/wishlist/wishlist_provider.dart';
import 'package:gardenia/shared/product_discription.dart';
import 'package:provider/provider.dart';

class HomeScreenGrid extends StatefulWidget {
  const HomeScreenGrid({
    super.key,
    required this.productCollection,
  });

  final CollectionReference<Object?> productCollection;

  @override
  State<HomeScreenGrid> createState() => _HomeScreenGridState();
}

class _HomeScreenGridState extends State<HomeScreenGrid> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        const aspectRatio = 3.0 / 4.0;
        return StreamBuilder(
          stream: widget.productCollection.snapshots(),
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
            print(
              '--------------------${data.length}',
            );
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: aspectRatio,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return ProductTile(
                      id: data[index]['id'],
                      name: data[index]['name'] ?? 'Empty',
                      subname: data[index]['category'] ?? 'Empty',
                      rate: data[index]['price'] ?? 'Empty',
                      image: data[index]['imageUrl'] ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9k33VDGg4WcrLISmAosSXtH9LnRke9pcaBQ&usqp=CAU",
                      description: data[index]['description'] ?? "empty");
                }
                return const Text('empty');
              },
            );
          },
        );
      },
    );
  }
}

class ProductTile extends StatefulWidget {
  final String name;
  final String subname;
  final String rate;
  final String image;
  final String description;
  final String id;
  const ProductTile({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isAddedToWishlist = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDiscription(
              id: widget.id,
              name: widget.name,
              price: widget.rate,
              category: widget.subname,
              discription: widget.description,
              img: widget.image,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width / 2.2,
            height: size.height / 4.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                Positioned(
                  left: size.width / 3.2,
                  top: 2,
                  child: IconButton(
                    icon: Icon(
                      isAddedToWishlist
                          ? CupertinoIcons.suit_heart_fill
                          : CupertinoIcons.heart,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () async {
                      final _value = WishlistModel(
                        category: widget.subname,
                        description: widget.description,
                        id: widget.id,
                        imageUrl: widget.image,
                        name: widget.name,
                        price: widget.rate,
                      );
                      context
                          .read<WishlistProvider>()
                          .addToWishlist(value: _value, context: context);
                    },
                  ),
                )
              ],
            ),
          ),
          Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
          Text(
            widget.subname,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "₹${widget.rate}.00",
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
