import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shop_app_fire_base/models/delevary_adress.dart';

class CheckoutProvider with ChangeNotifier {

  bool isloadding = false;

  TextEditingController fullName = TextEditingController();
  TextEditingController Governnorate = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController A_place_NearYou = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController BinaryCode = TextEditingController();
  LocationData?  setLoaction ;


  void validator(context , mytype) async {
    if (fullName.text.isEmpty) {
      Fluttertoast.showToast(msg: "fullName is empty");
    } else if (Governnorate.text.isEmpty) {
      Fluttertoast.showToast(msg: "Governnorate is empty");
    } else if (City.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is empty");
    } else if (A_place_NearYou.text.isEmpty) {
      Fluttertoast.showToast(msg: "A place NearYou is empty");
    } else if (PhoneNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "PhoneNumber is empty");
    } else if (BinaryCode.text.isEmpty) {
      Fluttertoast.showToast(msg: "BinaryCode is empty");
    } else if (setLoaction == null) {
      Fluttertoast.showToast(msg: "SetLocation is empty");
    } else{
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "fullName": fullName.text,
        "Governnorate": Governnorate.text,
        "City": City.text,
        "AplaceNearYou": A_place_NearYou.text,
        "PhoneNumber": PhoneNumber.text,
        "BinaryCode": BinaryCode.text,
        "adressType":mytype.toString(),
        "longitude": setLoaction!.longitude,
        "latitude": setLoaction!.latitude,
      }).then((value) async{
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }



  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        fullName: _db.get("fullName"),
        Governorate: _db.get("Governnorate"),
        addressType: _db.get("adressType"),
        A_Place_NearYou: _db.get("AplaceNearYou"),
        PhoneNumber: _db.get("PhoneNumber"),
        city: _db.get("City"),
        pinCode: _db.get("BinaryCode"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

}