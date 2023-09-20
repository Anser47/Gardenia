// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ProductTile extends StatefulWidget {
//   final String name;
//   final String subname;
//   final int rate;
//   final List<dynamic> image;
//   final String description;

//   const ProductTile({
//     Key? key,
//     required this.name,
//     required this.subname,
//     required this.rate,
//     required this.image,
//     required this.description,
//   }) : super(key: key);

//   @override
//   State<ProductTile> createState() => _ProductTileState();
// }

// class _ProductTileState extends State<ProductTile> {
//   bool isAddedToWishlist = false;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {},
//       child: Column(
//         children: [
//           Container(
//             width: 180,
//             height: 180,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 image: DecorationImage(
//                   image: NetworkImage(widget.image[0]),
//                   fit: BoxFit.cover,
//                 )),
//             child: Stack(
//               children: [
//                 Positioned(
//                     left: size.width / 3.2,
//                     top: -4,
//                     child: IconButton(
//                       icon: Icon(
//                         isAddedToWishlist
//                             ? CupertinoIcons.suit_heart_fill
//                             : CupertinoIcons.heart,
//                         color: Colors.black,
//                         size: 24,
//                       ),
//                       onPressed: () async {},
//                     ))
//               ],
//             ),
//           ),
//           Text(
//             widget.name,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             style: TextStyle(
//                 letterSpacing: .5,
//                 fontSize: 15,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w900),
//           ),
//           Text(
//             widget.subname,
//             maxLines: 1,
//             overflow: TextOverflow.clip,
//             style: const TextStyle(
//                 letterSpacing: .5,
//                 fontSize: 12,
//                 color: Colors.black54,
//                 fontWeight: FontWeight.w700),
//           ),
//           Text(
//             "₹${widget.rate}.00",
//             style: const TextStyle(
//                 letterSpacing: .5,
//                 fontSize: 15,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w900),
//           ),
//         ],
//       ),
//     );
//   }
// }
