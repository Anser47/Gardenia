import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/shared/bottomnavigation/core/constants.dart';
import 'package:gardenia/shared/common_widget/common_button.dart';
import 'package:gardenia/view/profile/accountile.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Expanded(
              child: Text(
                'Account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: gcolor,
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    height: 350,
                    width: 350,
                    child: Column(
                      children: [
                        AccountTile(
                          icon: Icons.person,
                          name: 'Personal Details',
                          voidCallback: () {},
                        ),
                        AccountTile(
                          icon: CupertinoIcons.bag_fill,
                          name: 'My Order',
                          voidCallback: () {},
                        ),
                        AccountTile(
                          icon: Icons.directions_bike,
                          name: 'Address',
                          voidCallback: () {},
                        ),
                        AccountTile(
                            icon: Icons.privacy_tip,
                            name: 'Privacy and Policy',
                            voidCallback: () {}),
                        AccountTile(
                          icon: Icons.file_copy,
                          name: 'Terms and Conditions',
                          voidCallback: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              const CommonButton(
                name: 'Log Out',
              )
            ],
          ),
        ),
      ),
    );
  }
}
