import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppImageFrameRadiousWidget extends StatelessWidget {
  String? imageLink ;
  double? radious ;
   AppImageFrameRadiousWidget({super.key, this.imageLink,this.radious});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius:  radious ,
      backgroundImage: NetworkImage( imageLink  ??   "https://media.assettype.com/gulfnews%2Fimport%2F2023%2F12%2F04%2FKatrina-Kaif_18c35bf7acc_large.jpg?w=480&auto=format%2Ccompress&fit=max"),);
  }
}
