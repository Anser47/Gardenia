import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromARGB(255, 202, 200, 200),
        ),
        // color: Colors.grey,
        height: size.height / 5,
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 90, top: 9),
              child: Text(
                'Name ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 85, top: 4),
              child: Text(
                'Brototype, Edathuruthikaran, Holdings Maradu, ernakulam, Kerala,682304,India, ',
                style: TextStyle(
                  fontSize: 17,
                ),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 85,
              ),
              child: Text(
                'Phone Number :84935679708',
                style: TextStyle(
                  fontSize: 17,
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
