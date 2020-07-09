import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
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

  final FocusNode search = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Listar OS'
        ),
        actions: <Widget>[
          GetBuilder<UserController>(
            init: UserController(),
            builder: (userController){
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
                            style: const TextStyle(color: Colors.white),
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
                  userController.setFilter(result??'');
                }
              );
            }
          ),
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
                      child: GetBuilder<UserController>(
                        init: UserController(),
                        builder: (userController){
                          return Text(
                            'OS do dia ${userController.dateFormated}',
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
                      GetBuilder<UserController>(
                        init: UserController(),
                        builder: (userController){
                          return IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: (){
                              showDatePicker(
                                context: context,
                                initialDate: userController.dateNotFormated,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                                  DateTime.now().day + 1)
                              ).then((date){
                                if(date == null){
                                  return;
                                } else{
                                  userController.setDate(date);
                                  userController.setFilter('');
                                  userController.findOrders(
                                    user: userController.user,
                                    onSucess: (){
                                      Get.snackbar(
                                        'Atualizado',
                                        'Os pedidos foram buscados!',
                                        colorText: Colors.white,
                                        backgroundColor: Colors.green,
                                        duration: const Duration(seconds: 2)
                                      );
                                    },
                                    onError: (e){
                                      Get.snackbar(
                                        e.code,
                                        'Não há pedidos para esta data',
                                        colorText: Colors.white,
                                        backgroundColor: Colors.grey,
                                        duration: const Duration(seconds: 2)
                                      );
                                    },
                                  );
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
            GetBuilder<UserController>(
              init: UserController(),
              builder: (userController){
                if(userController.isLoading){
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue)
                    )
                  );
                } else if(userController.orders.isEmpty){
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
                  return GetBuilder<UserController>(
                    init: UserController(),
                    builder: (userController){
                      return Expanded(
                        child: LiquidPullToRefresh(
                          key: _refreshIndicatorKey,
                          showChildOpacityTransition: false,
                          onRefresh: ()async{
                            userController.findOrders(
                              user: userController.user,
                              onSucess: (){
                                Get.snackbar(
                                  'Atualizado',
                                  'Os pedidos foram buscados!',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2)
                                );
                              },
                              onError: (e){
                                Get.snackbar(
                                  'Nada por hoje',
                                  'Não há pedidos para está data',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.grey,
                                  duration: const Duration(seconds: 2)
                                );
                              },
                            );
                          },
                          child: userController.filter != null && 
                          userController.filter != '' ? 
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
                                          userController.filter,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close, color: Colors.red),
                                      onPressed: (){
                                        userController.setFilter('');
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: userController.ordersFilter.length,
                                  itemBuilder: (ctx, index){
                                    if(userController.ordersFilter[index].dateOrder
                                    == userController.dateNotFormated.toString().substring(0, 10)
                                    ){
                                      return GestureDetector(
                                        onTap: (){
                                          Get.to(
                                            DetailOrderScreen(userController.ordersFilter[index], index)
                                          );
                                        },
                                        child: OrderOption(userController.ordersFilter[index])
                                      );
                                    } return Container();
                                  }
                                ),
                              ),
                            ],
                          ) :
                          ListView.builder(
                            itemCount: userController.orders.length,
                            itemBuilder: (ctx, index){
                              if(userController.orders[index].dateOrder
                              == '2020-07-08'
                              ){
                                return GestureDetector(
                                  onTap: (){
                                    Get.to(
                                      DetailOrderScreen(userController.orders[index], index)
                                    );
                                  },
                                  child: OrderOption(userController.orders[index])
                                );
                              } return Container();
                            }
                          ),
                        ),
                      );
                    },
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