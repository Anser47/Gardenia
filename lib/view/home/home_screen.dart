import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gardenia/shared/bottomnavigation/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:gardenia/shared/bottomnavigation/product_discription.dart';
import 'package:gardenia/view/wishlist/wishlist.dart';
import 'package:gardenia/view_model/fetch_product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  ValueNotifier<bool> notifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    notifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    notifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            gradient: gcolor,
                          ),
                          height: 180,
                          child: Image.asset(
                            'assets/gardenia1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 130,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 0.95,
                            enlargeCenterPage: true,
                          ),
                          items: List.generate(10, (index) {
                            return Builder(
                              builder: (context) {
                                return WishlistProductCard(
                                  constraints: constraints,
                                  name: 'Abc',
                                  price: 45,
                                );
                              },
                            );
                          }),
                        ),
                        SizedBox(
                          height: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 10),
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          elevation: 8,
                                          shadowColor: Colors.grey,
                                          backgroundColor: Colors.green),
                                      child: const Text(
                                        'Outdoor',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        elevation: 8,
                                        shadowColor: Colors.grey,
                                        backgroundColor: Colors.green),
                                    child: const Text('Indoor'),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 9.0,
                                  left: 14,
                                ),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final crossAxisCount =
                                constraints.maxWidth > 600 ? 3 : 2;
                            const aspectRatio = 3.0 / 4.0;
                            return StreamBuilder(
                              stream: productCollection.snapshots(),
                              builder: (context, snapshot) {
                                List<QueryDocumentSnapshot<Object?>> data = [];
                                if (snapshot.data == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                data = snapshot.data!.docs;
                                if (snapshot.data!.docs.isEmpty ||
                                    data.isEmpty) {
                                  return const Center(
                                    child: Text('No Products'),
                                  );
                                }
                                print('================== ${data.length}');
                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: aspectRatio,
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 1.0,
                                    mainAxisSpacing: 1.0,
                                  ),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    // if (snapshot.connectionState ==
                                    //     ConnectionState.waiting) {
                                    //   return const Center(
                                    //     child: CircularProgressIndicator(),
                                    //   );
                                    // }
                                    return ProductTile(
                                      name: data[index]['name'] ?? 'Empty',
                                      subname:
                                          data[index]['category'] ?? 'Empty',
                                      rate: data[index]['price'] ?? 'Empty',
                                      image: data[index]['imageUrl'] ??
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9k33VDGg4WcrLISmAosSXtH9LnRke9pcaBQ&usqp=CAU",
                                      description:
                                          data[index]['description'] ?? "empty",
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    notifier.value == true ? topContainer() : const SizedBox(),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  AnimatedContainer topContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      width: double.infinity,
      height: 115,
      color: Colors.white.withOpacity(0.6),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          SearchWidget(),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: InputBorder.none,
          labelText: "Search",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  final String name;
  final String subname;
  final String rate;
  final String image;
  final String description;

  const ProductTile({
    Key? key,
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
        children: [
          Container(
            width: 180,
            height: 180,
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
                  top: -4,
                  child: IconButton(
                    icon: Icon(
                      isAddedToWishlist
                          ? CupertinoIcons.suit_heart_fill
                          : CupertinoIcons.heart,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () async {},
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
