import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartcubit.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartstatus.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';

class CartItem extends StatefulWidget {
  bool test = false;
  String? image;
  String? Name;
  String? productId;
  int? Productcountity;
  int? price;
  GestureTapCallback? function;
  var Unitdata;

  CartItem(this.test, this.image, this.Name, this.productId,
      this.Productcountity, this.price,
      {this.Unitdata, this.function});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int count;

  getCount() {
    setState(() {
      count = widget.Productcountity!;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    ReviewCartProvider provider = Provider.of(context);
    return BlocProvider(
      create: (BuildContext context) => countercubit(),
      child: BlocConsumer<countercubit, elamalia>(
          listener: (context, state) {},
          builder: (context, state) {
            return widget.test == false
                ? Column(
                    children: [
                      SizedBox(
                        height: 90.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              widget.image!,
                              width: 100.0,
                              height: 100.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.Name!,
                                    style: const TextStyle(fontSize: 17.0),
                                  ),
                                  Text('${widget.price}\$'),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        // ' 5 Kilo',
                                        ' ${widget.Unitdata}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 12.0),
                                      ),
                                      const SizedBox(
                                        width: 50.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 3.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (count == 1) {
                                                        count = 1;
                                                      } else {
                                                        count--;
                                                      }
                                                    });
                                                    provider
                                                        .updateReviewCartData(
                                                      cartId: widget.productId!,
                                                      cartName: widget.Name!,
                                                      cartImage: widget.image!,
                                                      cartPrice: widget.price!,
                                                      cartQuantity: count,
                                                    );
                                                    provider
                                                        .getReviewCartData();
                                                  },
                                                  child:
                                                      const Icon(Icons.remove)),
                                            ),
                                            Text('$count'),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 3.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      count++;
                                                    });
                                                    provider
                                                        .updateReviewCartData(
                                                      cartId: widget.productId!,
                                                      cartName: widget.Name!,
                                                      cartImage: widget.image!,
                                                      cartPrice: widget.price!,
                                                      cartQuantity: count,
                                                    );
                                                    provider
                                                        .getReviewCartData();
                                                  },
                                                  child: const Icon(Icons.add)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 10.0, top: 30),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: widget.function,
                                    child: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.blue,
                                      size: 35,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: 1.0,
                                      ),
                                      child: Text(
                                        'Delete',
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 90.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              widget.image!,
                              width: 100.0,
                              height: 100.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.Name!,
                                    style: const TextStyle(fontSize: 17.0),
                                  ),
                                  Text('${widget.price}\$'),
                                  const Spacer(),
                                  Text(
                                    '${widget.Unitdata}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 10.0, top: 30),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: widget.function,
                                    child: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.blue,
                                      size: 35,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: 1.0,
                                      ),
                                      child: Text(
                                        'Delete',
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
          }),
    );
  }
}
