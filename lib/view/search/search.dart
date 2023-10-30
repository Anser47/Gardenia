import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/view/home/home_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topContainer(),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: HomeScreenGrid(productCollection: productCollection),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer topContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      width: double.infinity,
      height: 115,
      color: Colors.black.withOpacity(0.1),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 5,
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
