import 'package:flutter/material.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';


class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listar OS'
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}