import 'package:flutter/material.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';

enum PaymentCategory { cashondelivary, paynow }

class CheckoutSreen extends StatefulWidget {
  const CheckoutSreen({super.key});

  @override
  State<CheckoutSreen> createState() => _CheckoutSreenState();
}

class _CheckoutSreenState extends State<CheckoutSreen> {
  PaymentCategory _change = PaymentCategory.paynow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height / 12,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      width: size.width / 8,
                    ),
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 9,
                right: 9,
              ),
              child: Card(
                elevation: 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromARGB(255, 202, 200, 200),
                  ),
                  // color: Colors.grey,
                  height: size.height / 5,
                  width: double.infinity,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 90, top: 9),
                        child: Text(
                          'Name ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 85, top: 4),
                        child: Text(
                          'Brototype, Edathuruthikaran, Holdings Maradu, ernakulam, Kerala,682304,India, ',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
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
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 9.0, bottom: 20, right: 9),
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        Text(
                          '  Edit Address',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9.0, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          ' Add Address',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: const EdgeInsets.all(10.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 202, 200, 200)),
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.6IeEzE8WjRisNJks_ytv-AHaJO%26pid%3DApi&f=1&ipt=41acb58a3b29bc0977c9f208e79bd3319dd0788e2b8f14f1917f68b5d6fbfed4&ipo=images',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Price: ₹99',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text('quantity'),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {},
                              ),
                              const Text('3'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Radio<PaymentCategory>(
                groupValue: _change,
                value: PaymentCategory.paynow,
                onChanged: (PaymentCategory? value) {
                  setState(() {
                    _change = value!;
                  });
                },
              ),
              title: const Text('Pay Now'),
            ),
            ListTile(
              leading: Radio<PaymentCategory>(
                groupValue: _change,
                value: PaymentCategory.cashondelivary,
                onChanged: (PaymentCategory? value) {
                  setState(() {
                    _change = value!;
                  });
                },
              ),
              title: const Text('Cash on delivery'),
            ),
            CommonButton(name: "Confirm order", voidCallback: () {})
          ],
        ),
      ),
    );
  }
}
