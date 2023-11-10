// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';

// // class ProductTile extends StatefulWidget {
// //   final String name;
// //   final String subname;
// //   final int rate;
// //   final List<dynamic> image;
// //   final String description;

// //   const ProductTile({
// //     Key? key,
// //     required this.name,
// //     required this.subname,
// //     required this.rate,
// //     required this.image,
// //     required this.description,
// //   }) : super(key: key);

// //   @override
// //   State<ProductTile> createState() => _ProductTileState();
// // }

// // class _ProductTileState extends State<ProductTile> {
// //   bool isAddedToWishlist = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     var size = MediaQuery.of(context).size;
// //     return GestureDetector(
// //       onTap: () {},
// //       child: Column(
// //         children: [
// //           Container(
// //             width: 180,
// //             height: 180,
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(25),
// //                 image: DecorationImage(
// //                   image: NetworkImage(widget.image[0]),
// //                   fit: BoxFit.cover,
// //                 )),
// //             child: Stack(
// //               children: [
// //                 Positioned(
// //                     left: size.width / 3.2,
// //                     top: -4,
// //                     child: IconButton(
// //                       icon: Icon(
// //                         isAddedToWishlist
// //                             ? CupertinoIcons.suit_heart_fill
// //                             : CupertinoIcons.heart,
// //                         color: Colors.black,
// //                         size: 24,
// //                       ),
// //                       onPressed: () async {},
// //                     ))
// //               ],
// //             ),
// //           ),
// //           Text(
// //             widget.name,
// //             overflow: TextOverflow.ellipsis,
// //             maxLines: 1,
// //             style: TextStyle(
// //                 letterSpacing: .5,
// //                 fontSize: 15,
// //                 color: Colors.black,
// //                 fontWeight: FontWeight.w900),
// //           ),
// //           Text(
// //             widget.subname,
// //             maxLines: 1,
// //             overflow: TextOverflow.clip,
// //             style: const TextStyle(
// //                 letterSpacing: .5,
// //                 fontSize: 12,
// //                 color: Colors.black54,
// //                 fontWeight: FontWeight.w700),
// //           ),
// //           Text(
// //             "₹${widget.rate}.00",
// //             style: const TextStyle(
// //                 letterSpacing: .5,
// //                 fontSize: 15,
// //                 color: Colors.black,
// //                 fontWeight: FontWeight.w900),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:gardenia/shared/core/constants.dart';
// import 'package:gardenia/view/home/home_screen.dart';
// import 'package:gardenia/view/wishlist/wishlist.dart';

// class Homw extends StatefulWidget {
//   const Homw({super.key});

//   @override
//   State<Homw> createState() => _HomwState();
// }

// class _HomwState extends State<Homw> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar:
//             AppBar(title: const Text('Welcome'), centerTitle: true, actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const WishlistScreen()));
//               },
//               icon: const Icon(
//                 Icons.favorite_border,
//                 size: 25,
//               )),
//         ]),
//         backgroundColor: Colors.white,
//         body: LayoutBuilder(builder: (context, constraints) {
//           return ListView(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   gradient: gcolor,
//                 ),
//                 height: 180,
//                 child: Image.asset(
//                   'assets/gardenia1.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 130,
//                   enableInfiniteScroll: true,
//                   scrollDirection: Axis.horizontal,
//                   autoPlay: true,
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                   viewportFraction: 0.95,
//                   enlargeCenterPage: true,
//                 ),
//                 items: List.generate(10, (index) {
//                   return Builder(
//                     builder: (context) {
//                       return WishlistProductCard(
//                         constraints: constraints,
//                         name: 'Abc',
//                         price: '45',
//                       );
//                     },
//                   );
//                 }),
//               ),
//               SizedBox(
//                 height: 130,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(top: 8.0, left: 10),
//                       child: Text(
//                         'Category',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 10,
//                           ),
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                                 shape: const StadiumBorder(),
//                                 elevation: 8,
//                                 shadowColor: Colors.grey,
//                                 backgroundColor: Colors.green),
//                             child: const Text(
//                               'Outdoor',
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                               shape: const StadiumBorder(),
//                               elevation: 8,
//                               shadowColor: Colors.grey,
//                               backgroundColor: Colors.green),
//                           child: const Text('Indoor'),
//                         ),
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(
//                         top: 9.0,
//                         left: 14,
//                       ),
//                       child: Text(
//                         'All',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // HomeScreenGrid(productCollection: productCollection),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
