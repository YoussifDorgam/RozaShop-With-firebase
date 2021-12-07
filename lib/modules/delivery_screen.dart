import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/delevary_adress.dart';
import 'package:shop_app_fire_base/modules/addnewadress_screen.dart';
import 'package:shop_app_fire_base/modules/payment_screen.dart';
import 'package:shop_app_fire_base/modules/single_delivery_item.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/chekout_provider.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  DeliveryAddressModel? value;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: const Text('Delivery Details',
          style: TextStyle(
            fontSize: 18.0,
              color: Colors.black
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navegato(context, const AddnewDeliveryAddress());
        },
        child: const Icon(Icons.add ,color: Colors.white,),
      ),
      bottomNavigationBar: Container(
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.blue),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: MaterialButton(
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navegato(context, const AddnewDeliveryAddress())
                : Navegato(
                    context,
                    PaymetScreen(
                      deliverAddressList: value!,
                    ));
          },
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? const Text('add new address' ,style: TextStyle(
              color: Colors.white
          ))
              : const Text('Payment Summary', style: TextStyle(
          color: Colors.white
          ),),
        ),
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.add_location_sharp, color: Colors.blue,),
            title: Text('Delivery to '),
          ),
          const Divider(
            height: 1,
            color: Colors.black,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Container()
              : Column(
                  children:
                      deliveryAddressProvider.getDeliveryAddressList.map((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      address:
                          '${e.Governorate} / ${e.city} / ${e.A_Place_NearYou} /BinaryCode:${e.pinCode}',
                      title: e.fullName,
                      addressType: e.addressType == "Addresstype.Home"
                          ? "Home"
                          : e.addressType == "Addresstype.Other"
                              ? "Other"
                              : "Work",
                      number: e.PhoneNumber,
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
