import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/home/home_grid.dart';
import 'package:gardenia/view/wishlist/wishlist.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({
    super.key,
    required this.productCollection,
  });

  final CollectionReference<Object?> productCollection;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: gcolor),
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
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
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.95,
                enlargeCenterPage: true,
              ),
              items: List.generate(10, (index) {
                return Builder(
                  builder: (context) {
                    return WishlistProductCard(
                      constraints: constraints,
                      name: 'Abc',
                      price: '45',
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            HomeScreenGrid(productCollection: productCollection),
          ],
        );
      }),
    );
  }
}
