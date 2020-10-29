import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/box_styles.dart';

class ShadowButton extends StatelessWidget {

  final IconData icon;

  const ShadowButton({this.icon});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: nMbox,
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}