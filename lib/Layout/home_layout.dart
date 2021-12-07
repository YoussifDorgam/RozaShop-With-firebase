import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/modules/cart_screen.dart';
import 'package:shop_app_fire_base/modules/cawentar.dart';
import 'package:shop_app_fire_base/modules/drawer_screen.dart';
import 'package:shop_app_fire_base/modules/product_screen.dart';
import 'package:shop_app_fire_base/modules/search_screen.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/add_user.dart';
import 'package:shop_app_fire_base/shared/provider/product_provider.dart';

class HomeLayoute extends StatefulWidget {
  const HomeLayoute({Key? key}) : super(key: key);

  @override
  State<HomeLayoute> createState() => _HomeLayouteState();
}

class _HomeLayouteState extends State<HomeLayoute> {
  @override
  void initState() {
    ProductProvider provider = Provider.of(context, listen: false);
    provider.getVegetableList();
    provider.getFruitesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider provider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: DrawerScreen(userProvider),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1.0,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navegato(
                  context,
                  SearchScreen(
                    Search: provider.gerAllProductSearch,
                  ));
            },
            icon: const CircleAvatar(
                radius: 17.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 5.0),
            child: IconButton(
              onPressed: () {
                Navegato(context, const CartScreen());
              },
              icon: const CircleAvatar(
                  radius: 17.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  BuildPanalItem(),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Vegetables',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navegato(
                              context,
                              SearchScreen(
                                Search: provider.getVegetableProductDataList,
                              ));
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: provider.getVegetableProductDataList.map((e) {
                        return SingleBroduct(
                          test: false,
                          name: e.productName,
                          image: e.productImage,
                          price: e.productPrice,
                          ProductId: e.productId!,
                          ProductUnit: e,
                          ontab: () {
                            Navegato(
                                context,
                                ProductScreen(
                                  e.productImage!,
                                  e.productName!,
                                  e.productPrice!,
                                  e.productId!,
                                  e,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Fruits',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navegato(
                              context,
                              SearchScreen(
                                Search: provider.getFruitesProductDataList,
                              ));
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: provider.getFruitesProductDataList.map((e) {
                        return SingleBroduct(
                          test: false,
                          name: e.productName,
                          image: e.productImage,
                          price: e.productPrice,
                          ProductId: e.productId!,
                          ProductUnit: e,
                          ontab: () {
                            Navegato(
                                context,
                                ProductScreen(
                                  e.productImage!,
                                  e.productName!,
                                  e.productPrice!,
                                  e.productId!,
                                  e,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}


