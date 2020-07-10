import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/message_controller.dart';
import 'package:grupocsl/controllers/orders/photos_after_controller.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/button_status.dart';
import 'package:grupocsl/views/orders/payment/payment_screen.dart';
import 'package:grupocsl/views/orders/photos/after/photos_after_screen.dart';
import 'package:grupocsl/views/orders/photos/before/photos_before_screen.dart';
import 'package:grupocsl/views/orders/signature/signature_screen.dart';
import 'package:url_launcher/url_launcher.dart';



class ButtonOptions extends StatelessWidget {

  final int index;
  final OrderService orderService;
  const ButtonOptions(this.orderService, this.index,);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
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
            GetBuilder<PhotoBeforeController>(
              builder: (photosBeforeController){
                return GetBuilder<PhotoAfterController>(
                  builder: (photoAfterController){
                    return ButtonStatus(
                      onPressed: (){
                        if(int.parse(orderService.statusAttendance) != 10){
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
                            index: index,
                            status: (int.parse(orderService.statusAttendance) + 1).toString(),
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
                          );
                        } else {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Aviso'),
                              content: const Text(
                                'Está OS já está fechada, não é possívvel fazxer alterações'
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: (){
                                    Get.back();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      onAction: (){
                        if(int.parse(orderService.statusAttendance) == 1){
                          launch('https://www.google.com/maps/place/${orderService.street}-'
                          '${orderService.city}');
                        } else if (int.parse(orderService.statusAttendance) == 3){
                          Get.to(PhotoBeforeScreen(orderService.id, userController.user.token));
                        } else if (int.parse(orderService.statusAttendance) == 5){
                          Get.to(PhotoAfterScreen(orderService.id, userController.user.token));
                        } else if(int.parse(orderService.statusAttendance) == 6){
                          Get.to(SignatureScreen(orderService.id, userController.user.token));
                        } else if(int.parse(orderService.statusAttendance) == 7){
                          Get.to(PaymentScreen(orderService));
                        } else if(int.parse(orderService.statusAttendance) == 10){
                          photosBeforeController.clearList();
                          photoAfterController.clearList();
                        }
                      },
                      setStatus: int.parse(userController.orders[index].statusAttendance)
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}