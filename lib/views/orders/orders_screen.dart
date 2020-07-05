import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/orders/orders_controller.dart';
import 'package:grupocsl/views/login/components/custom_form_field.dart';
import 'package:grupocsl/views/orders/components/order_option.dart';
import 'package:grupocsl/views/orders/details/details_order_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class OrdersScreen extends StatefulWidget {

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final SizeScreen sizeScreen = SizeScreen();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  
  FocusNode search = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listar OS'
        ),
        actions: <Widget>[
          GetBuilder<OrdersController>(
            init: OrdersController(),
            builder: (ordersController){
              return IconButton(
                icon: Icon(Icons.search),
                onPressed: ()async{
                  final String result = await showDialog<String>(
                    context: context,
                    builder: (ctx){
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: TextFormField(
                            focusNode: search,
                            decoration: InputDecoration(
                              hintText: 'Digite o Nº da OS',
                              hintStyle: const TextStyle(color: Colors.white),
                              icon: Icon(Icons.search, color: Colors.white),
                              border: InputBorder.none
                            ),
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (text){
                              Navigator.of(context).pop(text);
                            },
                            textInputAction: TextInputAction.go,
                          ),
                        ),
                      );
                    },
                  );
                  ordersController.setFilter(result??'');
                }
              );
            },
          )
        ],
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
                        init: OrdersController(),
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
                                  ordersController.setFilter('');
                                  ordersController.findOrders(token: '4084d68a42351aec51588bbbf87ffcfc640200ec');
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
                if(ordersController.isLoading){
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue)
                    )
                  );
                } else if(ordersController.orders.isEmpty){
                  return Center(
                    child: Card(
                      elevation: 10,
                      color: const Color(0xff196ca1),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: const <Widget>[
                             Text(
                              'Não há OS para este dia!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                  );
                }else{
                  return Expanded(
                    child: LiquidPullToRefresh(
                      key: _refreshIndicatorKey,
                      showChildOpacityTransition: false,
                      onRefresh: ()async{
                        ordersController.findOrders(token: '4084d68a42351aec51588bbbf87ffcfc640200ec');
                      },
                      child: ordersController.filter != null && 
                      ordersController.filter != '' ? 
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey[600]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "Você filtrou por: ",
                                      style: TextStyle(
                                        color: Colors.white
                                      )
                                    ),
                                    Text(
                                      ordersController.filter,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: (){
                                    ordersController.setFilter('');
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: ordersController.ordersFilter.length,
                              itemBuilder: (ctx, index){
                                if(ordersController.ordersFilter[index].dateOrder
                                == ordersController.dateNotFormated.toString().substring(0, 10)
                                ){
                                  print(ordersController.filter);
                                  return GestureDetector(
                                    onTap: (){
                                      Get.to(
                                        DetailOrderScreen(ordersController.ordersFilter[index])
                                      );
                                    },
                                    child: OrderOption(ordersController.ordersFilter[index])
                                  );
                                } return Container();
                              }
                      ),
                          ),
                        ],
                      ) :
                      ListView.builder(
                        itemCount: ordersController.orders.length,
                        itemBuilder: (ctx, index){
                          if(ordersController.orders[index].dateOrder
                          == ordersController.dateNotFormated.toString().substring(0, 10)
                          ){
                            print(ordersController.filter);
                            return GestureDetector(
                              onTap: (){
                                Get.to(
                                  DetailOrderScreen(ordersController.orders[index])
                                );
                              },
                              child: OrderOption(ordersController.orders[index])
                            );
                          } return Container();
                        }
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        )
      ),
    );
  }
}