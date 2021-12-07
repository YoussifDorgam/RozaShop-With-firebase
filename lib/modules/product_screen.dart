import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/product_model.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartcubit.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartstatus.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';
import 'package:shop_app_fire_base/shared/provider/wishlistbrovider.dart';

import 'cart_screen.dart';

enum SinginCharacter { fill, outline }

class ProductScreen extends StatefulWidget {
  final String string;
  final String image;
  final int price;
  final String ProductId;
  final ProductModel ProductUnit;

  ProductScreen(
    this.image,
    this.string,
    this.price,
    this.ProductId,
    this.ProductUnit,
  );

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var Unitdata;

  var firstvalue;

  void initState() {
    ReviewCartProvider provider = Provider.of(context, listen: false);
    super.initState();
  }

  bool wishListBool = false;

  getWishtListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.ProductId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("wishList");
                        },
                      ),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishtListBool();
    SinginCharacter? _character = SinginCharacter.fill;
    return BlocProvider(
      create: (BuildContext context) => countercubit(),
      child: BlocConsumer<countercubit, elamalia>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: const Text(
                  'Product overview',
                  style: TextStyle(color: Colors.black),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              backgroundColor: Colors.white,
              bottomNavigationBar: Row(
                children: [
                  bottomnavBar(
                      iconData: wishListBool == false
                          ? Icons.favorite_border
                          : Icons.favorite,
                      string: 'Add to Wishlist',
                      color: Colors.blue,
                      ontab: () {
                        setState(() {
                          wishListBool = !wishListBool;
                        });
                        if (wishListBool == true) {
                          wishListProvider.addWishListData(
                            wishListId: widget.ProductId,
                            wishListImage: widget.image,
                            wishListName: widget.string,
                            wishListPrice: widget.price,
                            wishListQuantity: 2,
                          );
                          Fluttertoast.showToast(
                              msg: "${widget.string} add Successfully");
                        } else {
                          wishListProvider.deleteWishtList(widget.ProductId);
                          Fluttertoast.showToast(
                              msg: "${widget.string} Deleted Successfully");
                        }
                      }),
                  bottomnavBar(
                      iconData: Icons.shopping_cart,
                      string: 'Go to cart',
                      color: Colors.black,
                      ontab: () {
                        Navegato(context, const CartScreen());
                      }),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        widget.string,
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '\$${widget.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 230.0,
                      child: Image.network(widget.image),
                    ),
                    const Text(
                      'Available Options',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green,
                              ),
                              Radio(
                                value: SinginCharacter.fill,
                                groupValue: _character,
                                activeColor: Colors.green[700],
                                onChanged: (value) {
                                  setState(() {
                                    _character = value as SinginCharacter?;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Text('\$${widget.price}')),
                        Row(
                          children: [
                            //   InkWell(
                            //     onTap: () {
                            //       provider.addReviewCartData(
                            //         cartId: widget.ProductId,
                            //         cartName: widget.string,
                            //         cartImage: widget.image,
                            //         cartPrice: widget.price,
                            //         cartUnit: Unitdata ?? firstvalue  ,
                            //         cartQuantity:
                            //             countercubit.get(context).counter,
                            //       );
                            //     },
                            //     child: Container(
                            //       width: 60.0,
                            //       height: 20.0,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         border: Border.all(color: Colors.black),
                            //       ),
                            //       child: Row(
                            //         children: const [
                            //           SizedBox(
                            //             width: 5.0,
                            //           ),
                            //           Icon(
                            //             Icons.add,
                            //             color: Colors.amber,
                            //             size: 20,
                            //           ),
                            //           Padding(
                            //             padding: EdgeInsetsDirectional.only(
                            //                 start: 3.0),
                            //             child: Text(
                            //               'Add',
                            //               maxLines: 1,
                            //               style: TextStyle(fontSize: 8.0),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'about this Product',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Expanded(
                      child: Text(
                        'The tomato is native to western South America and Central America. In 1519, Cortez discovered tomatoes growing in Montezuma\'s gardens and brought seeds back to Europe where they were planted  ornamental curiosities but not eaten',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Widget bottomnavBar(
        {IconData? iconData,
        String? string,
        Color? color,
        GestureTapCallback? ontab}) =>
    Expanded(
      child: GestureDetector(
        onTap: ontab,
        child: Container(
          height: 60.0,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                string!,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
