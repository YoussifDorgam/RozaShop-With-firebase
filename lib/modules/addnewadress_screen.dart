import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/chekout_provider.dart';

import 'cusmmwidgt.dart';
import 'google_map.dart';

class AddnewDeliveryAddress extends StatefulWidget {
  const AddnewDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddnewDeliveryAddress> createState() => _AddnewDeliveryAddressState();
}

enum Addresstype {
  Home,
  Work,
  Other,
}

class _AddnewDeliveryAddressState extends State<AddnewDeliveryAddress> {
  var mytype = Addresstype.Home;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.blue),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: MaterialButton(
          onPressed: () {
            checkoutProvider.validator(context, mytype);
          },
          child: const Text('Add new address'),
        ),
      ),
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Add delivery address',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        leading:IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            CostomTextField(
              labText: 'Firs mame & Last name',
              controller: checkoutProvider.fullName,
            ),
            CostomTextField(
              labText: 'Governorate',
              controller: checkoutProvider.Governnorate,
            ),
            CostomTextField(
              labText: 'city',
              controller: checkoutProvider.City,
            ),
            CostomTextField(
              labText: 'A Place near you',
              controller: checkoutProvider.A_place_NearYou,
            ),
            CostomTextField(
              labText: 'Phone number',
              controller: checkoutProvider.PhoneNumber,
            ),
            CostomTextField(
              labText: 'Binary code ',
              controller: checkoutProvider.BinaryCode,
            ),
            InkWell(
              onTap: () {
                Navegato(context, const GoogleMapScreen());
              },
              child: SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setLoaction == null
                        ? const Text('Set Location')
                        : const Text('Done!'),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const ListTile(
              title: Text('Address type'),
            ),
            RadioListTile(
              value: Addresstype.Home,
              groupValue: mytype,
              title: const Text('home'),
              onChanged: (Addresstype? value) {
                setState(() {
                  mytype = value!;
                });
              },
              secondary: const Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            RadioListTile(
              value: Addresstype.Work,
              groupValue: mytype,
              title: const Text('Work'),
              onChanged: (Addresstype? value) {
                setState(() {
                  mytype = value!;
                });
              },
              secondary: const Icon(
                Icons.work,
                color: Colors.blue,
              ),
            ),
            RadioListTile(
              value: Addresstype.Other,
              groupValue: mytype,
              title: const Text('others'),
              onChanged: (Addresstype? value) {
                setState(() {
                  mytype = value!;
                });
              },
              secondary: const Icon(
                Icons.devices_other,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
