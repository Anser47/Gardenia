import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/model/address_model.dart';
import 'package:gardenia/shared/core/constants.dart';

class NameEditScreen extends StatelessWidget {
  NameEditScreen({
    required this.id,
    super.key,
  });
  String id;
  final _nameControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextFields(
                inputType: TextInputType.name,
                labelText: 'name',
                validator: 'Please Enter  Name',
                nameControllor: _nameControllor),
          ),
          kHeight20,
          CommonButtonTwo(
            change: _nameControllor.text,
            id: id,
            name: 'Update new name',
            voidCallback: () async {
              await FirebaseFirestore.instance
                  .collection('Address')
                  .doc(id)
                  .update({
                'name': _nameControllor.text.trim(),
              });
            },
          ),
        ],
      ),
    );
  }
}

class EditPincode extends StatelessWidget {
  EditPincode({super.key, required this.id});
  final String id;
  final _nameControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextFields(
                inputType: TextInputType.name,
                labelText: 'Productname',
                validator: 'Please Enter Product Name',
                nameControllor: _nameControllor),
          ),
          kHeight20,
          CommonButtonTwo(
            change: _nameControllor.text,
            id: id,
            name: 'Update new name',
            voidCallback: () async {
              await FirebaseFirestore.instance
                  .collection('Address')
                  .doc(id)
                  .update({
                'name': _nameControllor.text.trim(),
              });
            },
          ),
        ],
      ),
    );
  }
}
