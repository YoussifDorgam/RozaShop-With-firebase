import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/shared/provider/chekout_provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
//LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  LatLng _initialcameraposition = LatLng(24.8918682, 30.9758651);
  GoogleMapController? controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude!, event.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialcameraposition,
              ),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(
                    right: 60, left: 10, bottom: 40, top: 40),
                child: MaterialButton(
                  onPressed: () async{
                    await _location.getLocation().then((value) {
                      checkoutProvider.setLoaction = value ;
                    });
                    Fluttertoast.showToast(msg: "Done!");
                    Navigator.of(context).pop();
                  },
                  child: const Text("Set Location" ,style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
