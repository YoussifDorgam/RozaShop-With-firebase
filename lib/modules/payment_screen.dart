import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/delevary_adress.dart';
import 'package:shop_app_fire_base/modules/single_delivery_item.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';

import 'my_google_pay.dart';
import 'p_order_item.dart';

class PaymetScreen extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;

  PaymetScreen({Key? key, required this.deliverAddressList}) : super(key: key);

  @override
  State<PaymetScreen> createState() => _PaymetScreenState();
}

enum Addresstype {
  Home,
  OnlinePayment,
}

class _PaymetScreenState extends State<PaymetScreen> {
  var mytype = Addresstype.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 30;
    double? discountValue;
    double shippingChanrge = 3.7;
    double? total;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    } else {
      total = totalPrice;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ListTile(
        title: const Text('Total Amount'),
        subtitle: Text(
          "\$${total + 5}",
          style: const TextStyle(color: Colors.green),
        ),
        trailing: SizedBox(
          width: 160.0,
          height: 40.0,
          child: MaterialButton(
            onPressed: () {
              mytype == Addresstype.OnlinePayment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyGooglePay(
                          total: total,
                        ),
                      ),
                    )
                  : Container();
            },
            child: const Text(
              'Place Order',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: const Text('Payment Summary',style: TextStyle(
          fontSize: 18.0,
          color: Colors.black
        ),),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => Column(
            children: [
              SingleDeliveryItem(
                address:
                    '${widget.deliverAddressList.Governorate} / ${widget.deliverAddressList.city} / ${widget.deliverAddressList.A_Place_NearYou} /BinaryCode:${widget.deliverAddressList.pinCode}',
                title: widget.deliverAddressList.fullName,
                addressType:
                    widget.deliverAddressList.addressType == "Addresstype.Home"
                        ? "Home"
                        : widget.deliverAddressList.addressType ==
                                "Addresstype.Other"
                            ? "Other"
                            : "Work",
                number: widget.deliverAddressList.PhoneNumber,
              ),
              const Divider(
                height: 1,
              ),
              ExpansionTile(
                children: reviewCartProvider.getReviewCartDataList.map((e) {
                  return OrderItem(
                    e: e,
                  );
                }).toList(),
                title: Text(
                    "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
              ),
              ListTile(
                minVerticalPadding: 5.0,
                leading: const Text(
                  'Sub Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text("\$${totalPrice + 5}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              ListTile(
                minVerticalPadding: 5.0,
                leading: Text(
                  'Shipping Charge',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Text("\$${discountValue ?? 0}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              ListTile(
                minVerticalPadding: 5.0,
                leading: Text(
                  'Compen Discount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: const Text('\$10',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Divider(),
              const ListTile(
                leading: Text('Payment Options'),
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
                value: Addresstype.OnlinePayment,
                groupValue: mytype,
                title: const Text('Online Payment'),
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
            ],
          ),
        ),
      ),
    );
  }
}
