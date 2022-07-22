import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/modules/delivery_screen.dart';
import 'package:shop_app_fire_base/modules/loginview.dart';
import 'package:shop_app_fire_base/shared/provider/add_user.dart';
import 'package:shop_app_fire_base/shared/sharedprefrance/cash_helper.dart';

class ProfileScreen extends StatefulWidget {
  UserProvider userProvider;

  ProfileScreen(this.userProvider);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider? userProvider;

  Future<void> signOutWithGoogle() async {
    // Sign out with firebase
    await userProvider!.firebaseAuth.signOut();
    // Sign out with google
    await userProvider!.qoogleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {

    userProvider = Provider.of<UserProvider>(context);
    var userdata = widget.userProvider.currentUserData;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150.0,
                  width: double.infinity,
                  color: Colors.blue,
                ),
                Container(
                  height: 600.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 2.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                userdata.userName!,
                                style: const TextStyle(fontSize: 17.0),
                              ),
                              Text(
                                userdata.userEmail!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25.0,
                          ),
                          const Icon(Icons.edit, color: Colors.blue),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      BulidProfileItem(
                          Icons.shopping_cart_outlined, 'My Orders'),
                      BulidProfileItem(
                          Icons.location_on_outlined, 'My Delivery Address', ontab: ()
                      {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const DeliveryScreen() ));
                      }),
                      BulidProfileItem(Icons.person_add_alt, 'Refer A Friends'),
                      BulidProfileItem(
                          Icons.file_copy_outlined, 'Terms & Conditions'),
                      BulidProfileItem(Icons.policy_outlined, 'privacy police'),
                      BulidProfileItem(Icons.add_chart, 'About Us'),
                      BulidProfileItem(Icons.logout, 'Log Out', ontab: ()
                      {
                        signOutWithGoogle().then((value) => {
                        cachHelper.removeData('uid').then((value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen() ));
                        })
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 20.0, top: 100.0),
              child: CircleAvatar(
                radius: 55.0,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(userdata.userImage!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget BulidProfileItem(IconData iconData, String title,
    {GestureTapCallback? ontab}) {
  return Column(
    children: [
      const Divider(
        color: Colors.grey,
      ),
      ListTile(
        onTap: ontab,
        leading: Icon(
          iconData,
          size: 32,
          color: Colors.black87,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black87, fontSize: 17.0),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.blue,
        ),
      ),
    ],
  );
}
