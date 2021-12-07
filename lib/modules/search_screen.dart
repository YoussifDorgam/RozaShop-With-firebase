import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/models/product_model.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel>? Search;

  const SearchScreen({Key? key, this.Search}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedItem = '';
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchFood = widget.Search!.where((element) {
      return element.productName!.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider provider = Provider.of(context);
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              onChanged: (vlaue) {
                setState(() {
                  query = vlaue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Column(
            children: _searchItem.map((e) {
              return BuildSearchItem(
                  e.productImage!, e.productName!, e.productPrice!, ontab: () {
                provider.addReviewCartData(
                  cartId: e.productId!,
                  cartName: e.productName!,
                  cartImage: e.productImage!,
                  cartPrice: e.productPrice!,
                  cartQuantity: 1,
                  cartUnit: "1 Kilo",
                );
                Fluttertoast.showToast(
                    msg: "${e.productName} add Successfully");
              }, productk: () {});
            }).toList(),
          ),
        ],
      ),
    );
  }

  void onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              child: buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          //  leading: Icon(Icons.ac_unit),
          title: Text('5 kg'),
          onTap: () => selectItem('5 kg'),
        ),
        ListTile(
          // leading: Icon(Icons.accessibility_new),
          title: Text('10 kg'),
          onTap: () => selectItem('10 kg'),
        ),
        ListTile(
          // leading: Icon(Icons.assessment),
          title: Text('15 kg'),
          onTap: () => selectItem('15 kg'),
        ),
      ],
    );
  }

  void selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }
}

Widget BuildSearchItem(
  String productImage,
  String productName,
  int productPrice, {
  GestureTapCallback? ontab,
  GestureTapCallback? productk,
}) =>
    Column(
      children: [
        SizedBox(
          height: 80.0,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                productImage,
                width: 100.0,
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        productName,
                        style: const TextStyle(fontSize: 17.0),
                      ),
                    ),
                    Text('$productPrice\$'),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 3.0),
                          child: Text(
                            '1 kilo',
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0, top: 30),
                child: InkWell(
                  onTap: ontab,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 5.0),
                          child: Text(
                            'Add',
                            maxLines: 1,
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
