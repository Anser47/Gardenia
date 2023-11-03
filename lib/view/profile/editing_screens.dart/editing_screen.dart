import 'package:flutter/material.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';
import 'package:gardenia/shared/core/constants.dart';
import 'package:gardenia/view/profile/editing_screens.dart/editing_page.dart';

class EditingScreen extends StatelessWidget {
  EditingScreen({
    required this.id,
    super.key,
  });
  String id;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'Full Name',
                voidCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NameEditScreen(id: id),
                    ),
                  );
                }),
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'Pin Code',
                voidCallback: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ProductNameEditScreen(id: widget.id),
                  //   ),
                  // );
                }),
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'City name',
                voidCallback: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => PriceEditScreen(id: widget.id),
                  //   ),
                  // );
                }),
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'State',
                voidCallback: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => QuantityEditScreen(id: widget.id),
                  //   ),
                  // );
                }),
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'Phone Number',
                voidCallback: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => CategoryEditScreen(id: widget.id),
                  //   ),
                  // );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'House',
                voidCallback: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         DescriptionEditScreen(id: widget.id),
                  //   ),
                  // );
                }),
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'Area',
                voidCallback: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         DescriptionEditScreen(id: widget.id),
                  //   ),
                  // );
                }),
          ),
        ],
      ),
    );
  }
}
