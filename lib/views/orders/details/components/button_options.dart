import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/message_controller.dart';
import 'package:grupocsl/controllers/orders/status_controller.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/button_status.dart';


class ButtonOptions extends StatelessWidget {

  final int index;
  final OrderService orderService;
  const ButtonOptions(this.orderService, this.index,);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (userController){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GetBuilder<MessageController>(
              init: MessageController(),
              builder: (messageController){
                return RaisedButton(
                  color: Colors.yellow,
                  onPressed: (){
                    Get.bottomSheet(
                      BottomSheet(
                        onClosing: (){},
                        builder: (ctx){
                          return FutureBuilder(
                            future: messageController.setMessage(),
                            builder: (ctx, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              else if(snapshot.data == null){
                                return const Text('Por enquanto nada');
                              } else{
                                return Container(
                                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        snapshot.data["texto"]["Title"] as String,
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      Text(
                                        snapshot.data["texto"]["descricao"] as String,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        }
                      ),
                    );
                  },
                  child: const Text(
                    'Aviso'
                  ),
                );
              },
            ),
            GetBuilder<StatusController>(
              init: StatusController(),
              builder: (statusController){
                return ButtonStatus(
                  onPressed: (status){
                    userController.setStatusOrder(
                      onOrders: (){
                        Get.snackbar(
                          'Atualizados',
                          'Pedidos atualizados!',
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      },
                      token: userController.user.token,
                      os: orderService.id,
                      status: (int.parse(orderService.statusAttendance??statusController.status) + 1).toString(),
                      onFail: (e){
                        Get.snackbar(
                          'Erro',
                          e.title,
                          colorText: Colors.white,
                          backgroundColor: Colors.red
                        );
                      },
                      onSucess: (){
                        Get.snackbar(
                          'Sucesso',
                          'Status alterado!',
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      },
                      setStatusOdersAtten: statusController.setStatus
                    );
                  },
                  onAction: (){},
                  setStatus: int.parse(statusController.status??orderService.statusAttendance)
                );
              },
            ),
          ],
        );
      },
    );
  }
}