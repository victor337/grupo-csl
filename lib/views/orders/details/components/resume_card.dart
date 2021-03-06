import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/set_status.dart';


class ResumeCard extends StatelessWidget {

  final OrderService orderService;
  final int index;
  ResumeCard(this.orderService, this.index);

  final SetStatus setStatus = SetStatus();
  
  @override
  Widget build(BuildContext context) {

    String setPayment(String nume){
      if(nume == '0'){
        return 'Em aberto';
      } else if(nume == '1'){
        return 'Paga';
      } else{
        return 'Em aberto';
      }
    }

    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ordem de Serviço: ${orderService.id}',
            ),
            const SizedBox(height: 5,),
            GetBuilder<UserController>(
              builder: (userController){
                return Text(
                  'Status: ${setStatus.setStatusAtt(int.parse(userController.orders[index].statusAttendance))}',
                );
              },
            ),
            const SizedBox(height: 5,),
            Text(
              'Pago: ${setPayment(orderService.payment)}',
            ),
            const SizedBox(height: 5,),
            Text(
              'Tipo de pagamento: ${orderService.typePayment}',
            ),
          ],
        ),
      ),
    );
  }
}