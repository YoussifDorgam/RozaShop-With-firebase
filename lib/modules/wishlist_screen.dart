import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/product_model.dart';
import 'package:shop_app_fire_base/shared/provider/wishlistbrovider.dart';
import 'cawentar.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    WishListProvider provider = Provider.of(context, listen: false);
    provider.getWishtListData();
    super.initState();
  }

  var wishListBool;
  getWishtListBool() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc()
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("cartUnit");
                        },
                      ),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getWishtListBool();
    WishListProvider provider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: const Text(
          'My Wishlist',
          style: TextStyle(fontSize: 18.0,color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black)),
      ),
      body: provider.getWishList.isEmpty
          ? const Center(child: Text('Wishlist is Empty ☹️',
        style: TextStyle(fontSize: 20.0, color: Colors.grey ,fontWeight: FontWeight.bold),

      ))
          : ListView.builder(
              itemBuilder: (context, index) {
                ProductModel data = provider.getWishList[index];
                return SingleBroduct(
                  test: true,
                  image: data.productImage!,
                  name: data.productName!,
                  ProductId: data.productId!,
                  ProductQuntity: data.productQuantity!,
                  price: data.productPrice!,
                  ontab: () {
                    provider.deleteWishtList(data.productId);
                    Fluttertoast.showToast(
                        msg: "${data.productName} Deleted Successfully");
                    provider.getWishtListData();
                  },
                );
              },
              itemCount: provider.getWishList.length,
            ),
    );
  }
}
