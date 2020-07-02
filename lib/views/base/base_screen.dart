import 'package:flutter/material.dart';
import 'package:grupocsl/constants/size_screen.dart';


class BaseScreen extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        width: sizeScreen.getWidthScreen(context)
      ),
    );
  }
}