import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/orders/orders_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/components/order_option.dart';


class OrdersScreen extends StatefulWidget {

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final SizeScreen sizeScreen = SizeScreen();

  final List<OrderService> orders = [
    OrderService(
      number: '12',
      hour: '08:00',
      client: 'Victor',
      date: '2/7/2020',
      status: 0,
    ),
    OrderService(
      number: '22',
      hour: '11:00',
      client: 'Alana',
      date: '3/7/2020',
      status: 2,
    ),
    OrderService(
      number: '40',
      hour: '14:00',
      client: 'João',
      date: '2/7/2020',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    color: const Color(0xff48c2e7),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      child: GetBuilder<OrdersController>(
                        init: OrdersController(),
                        builder: (ordersController){
                          return Text(
                            'OS do dia ${ordersController.date}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Outra data',
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                      GetBuilder<OrdersController>(
                        builder: (ordersController){
                          return IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                                  DateTime.now().day + 1)
                              ).then((date){
                                if(date == null){
                                  return;
                                } else{
                                  final String dateFormated =
                                    '${date.day}/${date.month}/${date.year}';
                                  ordersController.setDate(dateFormated);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder<OrdersController>(
              init: OrdersController(),
              builder: (ordersController){
                return Expanded(
                  child: ListView(
                    children: orders.where((element) => element.date == 
                    ordersController.date).map((e) => OrderOption(e)).toList(),
                  ),
                );
              },
            ),
          ],
        )
      ),
    );
  }
}