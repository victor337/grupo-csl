import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class CheckoutCard extends StatelessWidget {

  final OrderService orderService;
  const CheckoutCard(this.orderService);

  @override
  Widget build(BuildContext context) {

    String setDate(String date){
      final String year = date.substring(0, 4);
      final String month = date.substring(6, 7);
      final String day = date.substring(9, 10);
      return '$day/$month/$year';
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
              'Observação: ${orderService.observation??''}',
            ),
            const SizedBox(height: 5,),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderService.services.length,
              itemBuilder: (ctx, index){
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Código: ${orderService.services[index].id.toString()}: '
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Serviço: ${orderService.services[index].name.toString()}',
                            textAlign: TextAlign.center
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            'Quantidade: ${orderService.services[index].quantity.toString()}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            'Valor: R\$${orderService.services[index].value}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const Divider()
                  ],
                );
              }
            ),
            const SizedBox(height: 5,),
            Text(
              'Tipo: ${orderService.typePayment}',
            ),
            const SizedBox(height: 5,),
            Text(
              'Valor total: R\$${orderService.value}'
            ),
            const SizedBox(height: 5,),
            Text(
              'Data do pedido: ${setDate(orderService.dateOrder)}'
            ),
            const SizedBox(height: 5,),
            Text(
              'Horário: ${orderService.hour.substring(0, 5)}',
            ),
          ],
        ),
      ),
    );
  }
}