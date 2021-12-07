
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
    widget = HomeLayoute() ;
  }else
  {
    widget = LoginScreen() ;
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Startapp,
      ),
    );
  }
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:convert' show json;
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
//
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Google Sign In',
//       home: SignInDemo(),
//     ),
//   );
// }
//
// class SignInDemo extends StatefulWidget {
//   @override
//   State createState() => SignInDemoState();
// }
//
// class SignInDemoState extends State<SignInDemo> {
//   GoogleSignInAccount? _currentUser;
//   String _contactText = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact(_currentUser!);
//       }
//     });
//     _googleSignIn.signInSilently();
//   }
//
//   Future<void> _handleGetContact(GoogleSignInAccount user) async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//
//     setState(() {
//
//     });
//   }
//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }
//
//   Future<void> _handleSignOut() => _googleSignIn.disconnect();
//
//   Widget _buildBody() {
//     GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text("Signed in successfully."),
//           Text(_contactText),
//           ElevatedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           ElevatedButton(
//             child: const Text('REFRESH'),
//             onPressed: () => _handleGetContact(user),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           ElevatedButton(
//             child: const Text('SIGN IN'),
//             onPressed: _handleSignIn,
//           ),
//         ],
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }