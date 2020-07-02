import 'package:flutter/material.dart';
import 'package:grupocsl/common/drawer/components/drawer_option.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class CustomDrawer extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  final List<OrderService> orders = [
    OrderService(
      number: '22',
      hour: '08:00',
      client: 'Victor Hugo',
      status: 0
    ),
    OrderService(
      number: '27',
      hour: '10:00',
      client: 'Alana',
      status: 1
    ),
    OrderService(
      number: '25',
      hour: '12:00',
      client: 'João',
      status: 2
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: sizeScreen.getHeightScreen(context),
        width: sizeScreen.getWidthScreen(context),
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.fromLTRB(20, 40, 10, 40),
              width: sizeScreen.getWidthScreen(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Nome do usuário',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),
                  Text(
                    'Regional XXXX',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 11, 48, 71),
                padding: const EdgeInsets.only(top: 8),
                child: ListView(
                  children: orders.map((order){
                    return Column(
                      children: <Widget>[
                        DrawerOption(order),
                        const SizedBox(height: 8),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}