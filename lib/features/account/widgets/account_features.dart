import 'package:athleticarsenal/features/account/widgets/account_buttons.dart';
import 'package:flutter/material.dart';

class AccountFeatures extends StatefulWidget {
  @override
  State<AccountFeatures> createState() => _AccountFeaturesState();
}

class _AccountFeaturesState extends State<AccountFeatures> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButtons(
              text: "Orders",
              onPressed: () {},
            ),
            AccountButtons(
              text: "Turn Seller",
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButtons(
              text: "Log out",
              onPressed: () {},
            ),
            AccountButtons(
              text: "Wishlist",
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
