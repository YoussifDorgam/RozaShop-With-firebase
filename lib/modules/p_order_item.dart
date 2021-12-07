import 'package:flutter/material.dart';
import 'package:shop_app_fire_base/models/cart_model.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel? e;

  OrderItem({Key? key, this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e!.cartImage!,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e!.cartName!,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            e!.cartUnit!,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "\$${e!.cartPrice!}",
          ),
        ],
      ),
      subtitle: Text('${e!.cartQuantity!}'),
    );
  }
}
