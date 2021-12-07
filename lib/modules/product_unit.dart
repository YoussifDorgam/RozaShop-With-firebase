import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;

  ProductUnit({this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 7.0),
                child: Text(
                  '$title',
                  maxLines: 1,
                  style: const TextStyle(fontSize: 10.0),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(
              width: 5.0,
            ),
          ],
        ),
      ),
    ));
  }
}
