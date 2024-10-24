import 'package:my_rentals/const/constant.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const CustomCard({super.key, this.color, this.padding, required this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: cardBackgroundColor,
            elevation: 10,
            child: child,
                ),
            ),
          );
  }
}
