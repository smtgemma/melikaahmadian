import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/home/custom_furniture/controllers/custom_furniture_controller.dart';
// ignore: must_be_immutable
class AppImageFrameRadiousWidget extends StatelessWidget {
  String? imageLink ;
  double? radious ;
   AppImageFrameRadiousWidget({super.key, this.imageLink,this.radious});

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      radius:  radious ,
      backgroundImage: NetworkImage( imageLink  ??   "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg"),);
  }
}
