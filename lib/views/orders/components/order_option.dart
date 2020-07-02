import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class OrderOption extends StatelessWidget {

  final OrderService orderService;
  const OrderOption(this.orderService);

  @override
  Widget build(BuildContext context) {

    Color setColor(int status){
      if(status == 0) {
        return Colors.green;
      } else if(status == 1){
        return Colors.yellow;
      } else{
        return Colors.red;
      }
    }

    return Container(
      color: Colors.white,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text(
              'OS ${orderService.number}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Text(' - '),
            Text(
              orderService.hour,
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ],
        ),
        subtitle: Text(
          orderService.client,
        ),
        trailing: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: setColor(orderService.status)
          ),
        ),
      ),
    );
  }
}