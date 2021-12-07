import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/product_model.dart';
import 'package:shop_app_fire_base/modules/product_unit.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartcubit.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartstatus.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';

class SingleBroduct extends StatefulWidget {
  bool test = false;
  String? image;
  String? name;
  int? price;
  VoidCallback? ontab;
  String? ProductId;
  int? ProductQuntity;
  final ProductModel? ProductUnit;

  SingleBroduct(
      {required this.test,
      this.image,
      this.name,
      this.price,
      this.ProductId,
      this.ProductUnit,
      this.ontab,
      this.ProductQuntity});

  @override
  State<SingleBroduct> createState() => _SingleBroductState();
}

class _SingleBroductState extends State<SingleBroduct> {
  var Unitdata;
  var firstvalue;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider provider = Provider.of(context);
    widget.ProductUnit?.productUnit!.firstWhere((element) {
      setState(() {
        firstvalue = element;
      });
      return true;
    });
    return BlocProvider(
      create: (BuildContext context) => countercubit(),
      child: BlocConsumer<countercubit, elamalia>(
        listener: (context, state) {},
        builder: (context, state) {
          return widget.test == false
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150.0,
                    height: 225.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 10.0, end: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          GestureDetector(
                            onTap: widget.ontab,
                            child: Image(
                              image: NetworkImage(
                                '${widget.image}',
                              ),
                              height: 140.0,
                              width: 130,
                            ),
                          ),
                          Text('${widget.name}'),
                          Text(
                            '${widget.price}\$/${Unitdata ?? firstvalue}',
                            style: const TextStyle(
                                height: 1.1,
                                color: Colors.grey,
                                fontSize: 12.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              ProductUnit(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: widget
                                              .ProductUnit!.productUnit!
                                              .map<Widget>((e) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      Unitdata = e;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Text(
                                                      e,
                                                      style: const TextStyle(
                                                        color:
                                                            Colors.blue,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        );
                                      });
                                },
                                title: Unitdata ?? firstvalue,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              InkWell(
                                onTap: () {
                                  provider.addReviewCartData(
                                    cartId: widget.ProductId!,
                                    cartName: widget.name!,
                                    cartImage: widget.image!,
                                    cartPrice: widget.price!,
                                    cartUnit: Unitdata ?? firstvalue,
                                    cartQuantity:
                                        countercubit.get(context).counter,
                                  );
                                  Fluttertoast.showToast(
                                      msg: "${widget.name} add Successfully");
                                },
                                child: Container(
                                  width: 60.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 3.0),
                                        child: Text(
                                          'Add',
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 8.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                  widget.name!,
                                  style: const TextStyle(fontSize: 17.0),
                                ),
                                Text('${widget.price}\$'),
                                const Spacer(),
                                const Text(
                                  '1 Kilo',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
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
                                  onTap: widget.ontab,
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
        },
      ),
    );
  }
}
