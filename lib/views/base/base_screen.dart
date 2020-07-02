import 'package:flutter/material.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';


class BaseScreen extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Listar de OS"),
        ),
        drawer: CustomDrawer(),
        body: Container(
          height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
          width: sizeScreen.getWidthScreen(context)
        ),
      ),
    );
  }
}