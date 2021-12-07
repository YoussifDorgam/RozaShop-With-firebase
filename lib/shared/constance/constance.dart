import 'package:flutter/material.dart';

void Navegato(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

//// Panal Item
Widget BuildPanalItem() =>  Stack(
  children: [
    Container(
      width: double.infinity,
      height: 160.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey,
        image: const DecorationImage(
          image: NetworkImage(
              'https://th.bing.com/th/id/R.12c066fb2d73ef80c197b1b488bb5bcf?rik=EtcJM%2fhZlAOgzQ&riu=http%3a%2f%2fwww.southsfinestmeats.com%2fwp-content%2fuploads%2f2018%2f02%2fFresh-Vegetables-Colorful-Veg-195451207-1g8.jpg&ehk=7IgchnrBxPHq%2bYz7ogQVm5kzrGCdBzeH9P%2bgDNpve3w%3d&risl=&pid=ImgRaw&r=0'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 50.0,
        height: 40.0,
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            '🍎',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.green.shade900,
                    offset: const Offset(3, 3),
                  ),
                ]),
          ),
        ),
      ),
    ),
    const Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
      child: Text(
        '30% Off',
        style: TextStyle(color: Colors.white, fontSize: 40.0),
      ),
    ),
    const Padding(
      padding:
      EdgeInsetsDirectional.only(top: 110.0, start: 20.0),
      child: Text(
        'On all Vegetables products',
        style: TextStyle(color: Colors.white, fontSize: 15.0),
      ),
    ),
  ],
);
//Build Drawer Item
Widget BulidDrawerItem(IconData iconData, String title , {GestureTapCallback? ontab}) {
  return ListTile(
    onTap:ontab,
    leading: Icon(
      iconData,
      size: 32,
      color: Colors.black87,
    ),
    title: Text(
      title,
      style: const TextStyle(color: Colors.black87, fontSize: 17.0),
    ),
  );
}

void NavegatandFinish(context , Widget widget) => Navigator.pushAndRemoveUntil(context ,
  MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false ,
);







