import 'package:flutter/material.dart';


class SingleDeliveryItem extends StatelessWidget {
  final String? title;
  final String? address;
  final String? number;
  final String? addressType;
  SingleDeliveryItem({this.title, this.addressType, this.address, this.number});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5.0,),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title! ,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
              Container(
                width: 60,
                padding: EdgeInsets.all(1),
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    addressType!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.blue,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address!, ),
              const SizedBox(
                height: 5,
              ),
              Text(number!),
            ],
          ),
        ),
        const Divider(height: 1,color: Colors.black,),
      ],
    );
  }
}