import 'package:flutter/material.dart';
import 'package:gardenia/shared/bottomnavigation/core/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 18),
                child: Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ProductCard(
                  imageUrl:
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.HknsoENC5MynDj3g6reSyAHaHa%26pid%3DApi&f=1&ipt=389a54fc3cfc1ad8ae942c3503b7d1b354855ab0026eaa9c90703fbb3efb60b5&ipo=images',
                  name: 'Peace Lily',
                  description: 'sojfjbovaddfsaaaaaaa',
                  price: 324),
              ProductCard(
                  imageUrl:
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.33nQcbaDm9dHFLuhZadtBQHaKr%26pid%3DApi&f=1&ipt=881ff209cdf0df0c8abc53c1c3734ee55663599a1fc4918b8567d8e23d99b1ef&ipo=images',
                  name: 'Shedi',
                  description: 'sojfjbovaddfsaaaaaaa',
                  price: 324),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  ProductCard({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = size.height;
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 1.0,
      child: Container(
        height: 330,
        decoration: const BoxDecoration(gradient: gcolor),
        child: Column(
          children: [
            Image.network(widget.imageUrl,
                height: 200.0, width: double.infinity, fit: BoxFit.cover),
            ListTile(
              title: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.description),
              trailing: Text(
                '₹${widget.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: _decreaseQuantity,
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _increaseQuantity,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 56.0; // Adjust the height as needed
  final Widget title;
  final LinearGradient gradient;

  GradientAppBar({
    required this.title,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: preferredSize.height,
      child: Center(
        child: title,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
