import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/orders/orders_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/components/order_option.dart';
import 'package:grupocsl/views/orders/details/details_order_screen.dart';


class OrdersScreen extends StatefulWidget {

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final SizeScreen sizeScreen = SizeScreen();

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
                            'OS do dia ${ordersController.dateFormated}',
                            style: const TextStyle(
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
                                initialDate: ordersController.dateNotFormated,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                                  DateTime.now().day + 1)
                              ).then((date){
                                if(date == null){
                                  return;
                                } else{
                                  ordersController.setDate(date);
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
              builder: (ordersController){
                return FutureBuilder(
                  future: ordersController.findOrders(token: '3af3a6e054a31ad486ba7456a06d14536885f6d8'),
                  builder: (ctx, snapshot){
                    if(snapshot == null || !snapshot.hasData){
                      return const Center(child: CircularProgressIndicator());
                    } else{
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length as int,
                          itemBuilder: (ctx, index){
                            if(snapshot.data[index].dateOrder == ordersController.date){
                              return GestureDetector(
                                onTap: (){
                                  Get.to(
                                    DetailOrderScreen(snapshot.data[index] as OrderService)
                                  );
                                },
                                child: OrderOption(snapshot.data[index] as OrderService)
                              );
                            } return Container();
                          }
                        ),
                      );
                    }
                  }
                );
              },
            ),
          ],
        )
      ),
    );
  }
}