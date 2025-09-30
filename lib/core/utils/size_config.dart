import 'package:flutter/material.dart';

class SizeConfig {
  final BuildContext context;
  late final double width;
  late final double height;

  SizeConfig(this.context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
  }
}
