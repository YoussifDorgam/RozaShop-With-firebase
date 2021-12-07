import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/cart_model.dart';
import 'package:shop_app_fire_base/modules/cart_item.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';

import 'delivery_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ReviewCartProvider? provider;

  owAlertDialog(BuildContext context, ReviewCartModel cartModel) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        provider!.reviewCartDataDelete(cartModel.cartId);
        Navigator.pop(context);
        provider!.getReviewCartData();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Cart Product"),
      content: const Text("Are you Sure to delete This Product "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    ReviewCartProvider provider = Provider.of(context, listen: false);
    provider.getReviewCartData();
    //provider.updateReviewCartData();
    provider.reviewCartDataDelete(ReviewCartModel().cartId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    provider!.getReviewCartDataList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black)),
        title: const Text('Review Cart',style: TextStyle(fontSize: 18.0,color: Colors.black),),
      ),
      bottomNavigationBar: ListTile(
        title: const Text('Total Amount'),
        subtitle: Text(
          '\$${provider!.getTotalPrice()}',
          style: const TextStyle(color: Colors.green),
        ),
        trailing: SizedBox(
          width: 160.0,
          height: 40.0,
          child: MaterialButton(
            onPressed: () {
              if (provider!.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(msg: "Cart  is empty");
              } else {
                Navegato(context, const DeliveryScreen());
              }
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      body: provider!.getReviewCartDataList.isEmpty
          ? const Center(child: Text('Review Cart is Empty ☹  ',style: TextStyle(fontSize: 20.0, color: Colors.grey ,fontWeight: FontWeight.bold),))
          : ListView.builder(
              itemBuilder: (context, index) {
                ReviewCartModel data = provider!.getReviewCartDataList[index];
                return CartItem(
                  false,
                  data.cartImage!,
                  data.cartName!,
                  data.cartId!,
                  data.cartQuantity!,
                  data.cartPrice!,
                  Unitdata: data.cartUnit,
                  function: () {
                    owAlertDialog(context, data);
                  },
                );
              },
              itemCount: provider!.getReviewCartDataList.length,
            ),
    );
  }
}
