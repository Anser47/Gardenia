import 'package:flutter/material.dart';

class DeliveryHeading extends StatelessWidget {
  const DeliveryHeading({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        SizedBox(
          width: size.width / 6,
        ),
        const Text(
          'Delivery Address',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
