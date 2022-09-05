// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? webscreenlayout;
  final Widget? mobilescreenlayout;
  ResponsiveLayout(
      {@required this.mobilescreenlayout, @required this.webscreenlayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webscreensize) {
        return webscreenlayout!;
      } else {
        return mobilescreenlayout!;
      }
    });
  }
}
