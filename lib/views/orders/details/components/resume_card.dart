import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/details/components/set_status.dart';


class ResumeCard extends StatelessWidget {

  final OrderService orderService;
  ResumeCard(this.orderService);

  final SetStatus setStatus = SetStatus();
  
  @override
  Widget build(BuildContext context) {
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
            Text(
              'Status: ${setStatus.setStatusAtt(int.parse(orderService.statusAttendance))}',
            ),
            const SizedBox(height: 5,),
            Text(
              'Pago: ${orderService.statusDesc}',
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