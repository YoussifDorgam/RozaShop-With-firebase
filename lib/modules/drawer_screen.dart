import 'package:flutter/material.dart';
import 'package:shop_app_fire_base/modules/cart_screen.dart';
import 'package:shop_app_fire_base/modules/profile_screen.dart';
import 'package:shop_app_fire_base/modules/wishlist_screen.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/add_user.dart';

class DrawerScreen extends StatefulWidget {
  UserProvider userProvider ;
  DrawerScreen(this.userProvider);
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    var userdata = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                   CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 42.0,
                      backgroundImage: NetworkImage(
                          userdata.userImage ??
                          'https://scontent.fcai20-5.fna.fbcdn.net/v/t1.6435-9/247544961_917559112197383_6616302861625170039_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=2-FzxNl2m_8AX9qcudj&tn=uA-PB6iqfXNS99MI&_nc_ht=scontent.fcai20-5.fna&oh=7124e29d5d828cdf56cdec58f9943e6f&oe=61A58210'),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userdata.userName??
                          'Welcome Guest',
                          style: const TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                       Text(
                         userdata.userEmail ??
                        'Email',
                        style: TextStyle(color: Colors.black ,fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BulidDrawerItem(Icons.home_outlined, 'Home',
                ontab: () => Navigator.pop(context)),
            BulidDrawerItem(Icons.shopping_cart_outlined, 'Review Cart',
                ontab: () => Navegato(
                      context,
                      const CartScreen(),
                    )),
            BulidDrawerItem(
              Icons.person_outline,
              'My profile',
              ontab: () => Navegato(
                context,
                 ProfileScreen(widget.userProvider),
              ),
            ),
            BulidDrawerItem(Icons.notifications_none, 'Notifications'),
            BulidDrawerItem(Icons.star_border_outlined, 'Rating & Review '),
            BulidDrawerItem(
              Icons.favorite_border,
              'Wishlist',
              ontab: () => Navegato(
                context,
                 WishlistScreen(),
              ),
            ),
            BulidDrawerItem(Icons.copy_outlined, 'Raise a complaint'),
            BulidDrawerItem(Icons.format_quote_outlined, 'FAQS'),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Support',
                      style: TextStyle(
                          fontSize: 17.0, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: const [
                        Text('Call us'),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('+201027790713'),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: const [
                        Text('Mail us'),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('ya863733@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
