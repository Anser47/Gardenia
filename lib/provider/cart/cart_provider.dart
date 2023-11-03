import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  // BuildContext context;
  // AddressModel address;
  Future<void> addToCart({
    required CartModel value,
    required BuildContext? context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Cart').doc(value.id).set(
        {
          'name': value.name,
          'price': value.price,
          'quantity': value.quantity,
          'description': value.description,
          'category': value.category,
          'imageUrl': value.imageUrl,
          'id': value.id,
        },
      );
      notifyListeners();
    } on FirebaseException catch (error) {
      String errorMessage = 'An error occurred while adding the product.';

      if (error.code == 'permission-denied') {
        errorMessage =
            'Permission denied. You do not have the necessary permissions.';
      } else if (error.code == 'not-found') {
        errorMessage = 'The requested document was not found.';
      }

      showSnackbar(context!, errorMessage);
      print("Failed to add product: $error");
      notifyListeners();
    } catch (error) {
      showSnackbar(context!, 'An unexpected error occurred. Please try again.');
      print("Failed to add product: $error");
      notifyListeners();
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 100.0),
      content: Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

  Future<List<CartModel>> fetchCart() async {
    List<CartModel> cartList = [];
    try {
      var productCollectionSnapshot =
          await FirebaseFirestore.instance.collection('Cart').get();

      cartList = productCollectionSnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data();
          return CartModel.fromJson(data);
        },
      ).toList();
    } catch (e) {
      print("Error fetching products: $e");
    }
    notifyListeners();
    return cartList;
  }
}