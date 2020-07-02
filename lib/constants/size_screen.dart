import 'package:flutter/material.dart';


class SizeScreen {

  double getHeightScreen(BuildContext context){
    final double sizeFull = MediaQuery.of(context).size.height;
    final double sizePadding = MediaQuery.of(context).padding.top;

    final double sizeSafe = sizeFull - sizePadding;
    return sizeSafe;
  }

  double getHeightScreenWidthAppBar(BuildContext context, AppBar appBar){
    final double sizeAppBar = appBar.preferredSize.height;
    final double sizeFull = MediaQuery.of(context).size.height;
    final double sizePadding = MediaQuery.of(context).padding.top;

    final double sizeSafe = (sizeFull - sizePadding) - sizeAppBar;
    return sizeSafe;
  }

  double getWidthScreen(BuildContext context){
    return MediaQuery.of(context).size.width;
  }


}