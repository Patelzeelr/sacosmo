import 'package:cosmo_beauty/src/ui/home/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../provider/checkout_provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
          onPressed: () {
            checkoutProvider.validator(context, myType);
          },
          child: const Text(
            "Add Address",
            style: kTextWhiteStyle
          ),
          color: black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomField(
              "Title",
              checkoutProvider.title,
            ),
            CustomField(
              "First name",
              checkoutProvider.firstName,
            ),
            CustomField(
              "Last name",
              checkoutProvider.lastName,
            ),
            CustomField(
              "Mobile No",
              checkoutProvider.mobileNo,
            ),
            CustomField(
              "Alternate Mobile No",
              checkoutProvider.alternateMobileNo,
            ),
            CustomField(
              "Scoiety",
              checkoutProvider.scoiety,
            ),
            CustomField(
              "Street",
              checkoutProvider.street,
            ),
            CustomField(
              "Landmark",
              checkoutProvider.landmark,
            ),
            CustomField(
              "City",
              checkoutProvider.city,
            ),
            CustomField(
              "Aera",
              checkoutProvider.aera,
            ),
            CustomField(
              "Pincode",
              checkoutProvider.pincode,
            ),
          ],
        ),
      ),
    );
  }
}