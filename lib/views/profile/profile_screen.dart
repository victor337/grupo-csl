import 'package:flutter/material.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil'
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}