
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/Layout/home_layout.dart';
import 'package:shop_app_fire_base/modules/loginview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_app_fire_base/shared/end_point.dart';
import 'package:shop_app_fire_base/shared/provider/add_user.dart';
import 'package:shop_app_fire_base/shared/provider/cat_view_provider.dart';
import 'package:shop_app_fire_base/shared/provider/chekout_provider.dart';
import 'package:shop_app_fire_base/shared/provider/product_provider.dart';
import 'package:shop_app_fire_base/shared/provider/wishlistbrovider.dart';
import 'package:shop_app_fire_base/shared/sharedprefrance/cash_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await cachHelper.init();

  Widget widget  = HomeLayoute();
  uid = cachHelper.getData('uid');
  if( uid != null  )
  {
    widget = const HomeLayoute() ;
  }else
  {
    widget = const LoginScreen() ;
  }
  runApp( MyApp(Startapp: widget,));
}
//D:\shop_app_fire_base
class MyApp extends StatelessWidget {
  late final Widget Startapp ;
  MyApp({required this.Startapp});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider<ProductProvider>(
    create: (BuildContext context) => ProductProvider(),),
    ChangeNotifierProvider<UserProvider>(
    create: (BuildContext context) => UserProvider(),),
    ChangeNotifierProvider<ReviewCartProvider>(
    create: (BuildContext context) => ReviewCartProvider(),),
    ChangeNotifierProvider<WishListProvider>(
    create: (BuildContext context) => WishListProvider(),),
    ChangeNotifierProvider<CheckoutProvider>(
    create: (BuildContext context) => CheckoutProvider(),),
    ] ,
      child: DevicePreview(
        enabled: true,
        builder: (BuildContext context) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Startapp,
          );
        },

      ),
    );
  }
}
