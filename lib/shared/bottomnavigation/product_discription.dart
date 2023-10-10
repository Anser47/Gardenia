import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Description',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white60,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green], // Define your gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Like Button
                Stack(
                  children: [
                    Container(
                      width: constraints.maxWidth,
                      height: 300,
                      child: Image.network(
                        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.cmRHPqeRkBl0I2so0qf-NwHaJ4%26pid%3DApi&f=1&ipt=4fde98ddb1d7a2308fed60dfb4406d83a85fb53b852f6aeacca66e9e86989588&ipo=images', // Replace with your product image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      // top: 16.0,
                      right: 16.0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white54),
                        child: ClipOval(
                          child: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              // Handle like button tap
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 12),
                  child: Text(
                    'Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 12),
                  child: Text(
                    '\$99.99',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '''Product Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dapibus turpis ut odio dignissim, ac facilisis leo vehicula.Contrary to popular belief,
                       Lorem Ipsum is not simply random text. It has roots i piece of classical Latin literature from 45 BC, making it over 2000 years old.
                         Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up
                          one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32
                ''',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Buy Now'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
