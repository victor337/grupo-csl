import 'package:flutter/material.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/components/order_option.dart';


class OrdersScreen extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  final List<OrderService> orders = [
    OrderService(
      number: '12',
      hour: '08:00',
      client: 'Victor',
      status: 0,
    ),
    OrderService(
      number: '22',
      hour: '11:00',
      client: 'Alana',
      status: 2,
    ),
    OrderService(
      number: '40',
      hour: '14:00',
      client: 'João',
      status: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listar OS'
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: Colors.white,
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
              child: Row(
                children: <Widget>[
                  Text(
                    // ignore: missing_whitespace_between_adjacent_strings
                    'OS de ${DateTime.now().day}/'
                    '${DateTime.now().month}/${DateTime.now().year}'
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: orders.map((order) => OrderOption(order)).toList(),
              ),
            )
          ],
        )
      ),
    );
  }
}