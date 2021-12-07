import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app_fire_base/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> VegetableList = [];
  ProductModel? productModel;

  List<ProductModel> search = [];

/////////////////getVegetableList///////////////////
  getVegetableList() async {
    List<ProductModel> NewList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection('Vegetablesproduct').get();
    value.docs.forEach((element) {
      productModel = ProductModel(
        productImage: element.get("ProductImage"),
        productName: element.get("Productname"),
        productPrice: element.get("ProductIprice"),
        productId: element.get("productId"),
        productUnit: element.get("productUnit"),
      );
      NewList.add(productModel!);
      search.add(productModel!);
    });
    VegetableList = NewList;
    notifyListeners();
  }

  List<ProductModel> get getVegetableProductDataList {
    return VegetableList;
  }

  //////////////////// fruitedata ////////////////////
  List<ProductModel> FruiteList = [];

  getFruitesList() async {
    List<ProductModel> NewFruiteList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection('Fruitesproducts').get();
    value.docs.forEach((element) {
      print(element.data());
      productModel = ProductModel(
        productImage: element.get("ProductImage"),
        productName: element.get("Productname"),
        productPrice: element.get("ProductIprice"),
        productId: element.get("productId"),
        productUnit: element.get("productUnit"),
      );
      NewFruiteList.add(productModel!);
      search.add(productModel!);
    });
    FruiteList = NewFruiteList;
    notifyListeners();
  }

  List<ProductModel> get getFruitesProductDataList {
    return FruiteList;
  }

  /////////////// search //////////////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }

/////////// counter ///////////////////////////////

}
